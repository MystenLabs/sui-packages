module 0x9302c376dad40128acfe5b7c641eca13544b4d7296b59eb654d41e640dd85c67::gift_card {
    struct USDT has drop {
        dummy_field: bool,
    }

    struct GiftCard has store, key {
        id: 0x2::object::UID,
        amount: u64,
        redeemed: bool,
        message: 0x1::string::String,
        metadata_uri: 0x2::url::Url,
        balance_usdt: 0x2::balance::Balance<USDT>,
    }

    struct GiftCardCollection has key {
        id: 0x2::object::UID,
        token_id_counter: u64,
        admin: address,
    }

    struct GiftCardCreated has copy, drop {
        gift_card_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        uri: 0x1::string::String,
        message: 0x1::string::String,
    }

    struct GiftCardRedeemed has copy, drop {
        gift_card_id: 0x2::object::ID,
        redeemer: address,
        amount: u64,
    }

    public entry fun create_gift_card(arg0: &mut GiftCardCollection, arg1: address, arg2: 0x2::coin::Coin<USDT>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<USDT>(&arg2);
        arg0.token_id_counter = arg0.token_id_counter + 1;
        let v1 = GiftCard{
            id           : 0x2::object::new(arg5),
            amount       : v0,
            redeemed     : false,
            message      : 0x1::string::utf8(arg4),
            metadata_uri : 0x2::url::new_unsafe_from_bytes(arg3),
            balance_usdt : 0x2::coin::into_balance<USDT>(arg2),
        };
        let v2 = GiftCardCreated{
            gift_card_id : 0x2::object::id<GiftCard>(&v1),
            recipient    : arg1,
            amount       : v0,
            uri          : 0x1::string::from_ascii(0x2::url::inner_url(&v1.metadata_uri)),
            message      : v1.message,
        };
        0x2::event::emit<GiftCardCreated>(v2);
        0x2::transfer::transfer<GiftCard>(v1, arg1);
    }

    public fun get_gift_card_info(arg0: &GiftCard) : (u64, bool, 0x1::string::String, 0x1::string::String) {
        (arg0.amount, arg0.redeemed, arg0.message, 0x1::string::from_ascii(0x2::url::inner_url(&arg0.metadata_uri)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GiftCardCollection{
            id               : 0x2::object::new(arg0),
            token_id_counter : 0,
            admin            : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<GiftCardCollection>(v0);
    }

    public entry fun redeem_gift_card(arg0: &mut GiftCard, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.redeemed, 1);
        arg0.redeemed = true;
        let v0 = GiftCardRedeemed{
            gift_card_id : 0x2::object::id<GiftCard>(arg0),
            redeemer     : 0x2::tx_context::sender(arg1),
            amount       : arg0.amount,
        };
        0x2::event::emit<GiftCardRedeemed>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::from_balance<USDT>(0x2::balance::withdraw_all<USDT>(&mut arg0.balance_usdt), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

