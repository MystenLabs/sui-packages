module 0xf193e36bc2c9b3f895a938aa4c647e6ef879fc406794e8d80e40f9c504b72c22::gift_card {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct USDT has drop {
        dummy_field: bool,
    }

    struct GiftCard has store, key {
        id: 0x2::object::UID,
        amount: u64,
        coin_type: 0x1::string::String,
        redeemed: bool,
        message: 0x1::string::String,
        metadata_uri: 0x2::url::Url,
        balance_usdc: 0x2::balance::Balance<USDC>,
        balance_usdt: 0x2::balance::Balance<USDT>,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct GiftCardCollection has key {
        id: 0x2::object::UID,
        token_id_counter: u64,
        admin: address,
    }

    struct GiftCardCreated has copy, drop {
        token_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        coin_type: 0x1::string::String,
        uri: 0x1::string::String,
        message: 0x1::string::String,
    }

    struct GiftCardRedeemed has copy, drop {
        token_id: 0x2::object::ID,
        redeemer: address,
        amount: u64,
        coin_type: 0x1::string::String,
    }

    public entry fun create_gift_card_sui(arg0: &mut GiftCardCollection, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        arg0.token_id_counter = arg0.token_id_counter + 1;
        let v1 = GiftCard{
            id           : 0x2::object::new(arg5),
            amount       : v0,
            coin_type    : 0x1::string::utf8(b"SUI"),
            redeemed     : false,
            message      : 0x1::string::utf8(arg4),
            metadata_uri : 0x2::url::new_unsafe_from_bytes(arg3),
            balance_usdc : 0x2::balance::zero<USDC>(),
            balance_usdt : 0x2::balance::zero<USDT>(),
            balance_sui  : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
        };
        let v2 = GiftCardCreated{
            token_id  : 0x2::object::id<GiftCard>(&v1),
            recipient : arg1,
            amount    : v0,
            coin_type : 0x1::string::utf8(b"SUI"),
            uri       : 0x1::string::from_ascii(0x2::url::inner_url(&v1.metadata_uri)),
            message   : v1.message,
        };
        0x2::event::emit<GiftCardCreated>(v2);
        0x2::transfer::transfer<GiftCard>(v1, arg1);
    }

    public entry fun create_gift_card_usdc(arg0: &mut GiftCardCollection, arg1: address, arg2: 0x2::coin::Coin<USDC>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<USDC>(&arg2);
        arg0.token_id_counter = arg0.token_id_counter + 1;
        let v1 = GiftCard{
            id           : 0x2::object::new(arg5),
            amount       : v0,
            coin_type    : 0x1::string::utf8(b"USDC"),
            redeemed     : false,
            message      : 0x1::string::utf8(arg4),
            metadata_uri : 0x2::url::new_unsafe_from_bytes(arg3),
            balance_usdc : 0x2::coin::into_balance<USDC>(arg2),
            balance_usdt : 0x2::balance::zero<USDT>(),
            balance_sui  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = GiftCardCreated{
            token_id  : 0x2::object::id<GiftCard>(&v1),
            recipient : arg1,
            amount    : v0,
            coin_type : 0x1::string::utf8(b"USDC"),
            uri       : 0x1::string::from_ascii(0x2::url::inner_url(&v1.metadata_uri)),
            message   : v1.message,
        };
        0x2::event::emit<GiftCardCreated>(v2);
        0x2::transfer::transfer<GiftCard>(v1, arg1);
    }

    public entry fun create_gift_card_usdt(arg0: &mut GiftCardCollection, arg1: address, arg2: 0x2::coin::Coin<USDT>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<USDT>(&arg2);
        arg0.token_id_counter = arg0.token_id_counter + 1;
        let v1 = GiftCard{
            id           : 0x2::object::new(arg5),
            amount       : v0,
            coin_type    : 0x1::string::utf8(b"USDT"),
            redeemed     : false,
            message      : 0x1::string::utf8(arg4),
            metadata_uri : 0x2::url::new_unsafe_from_bytes(arg3),
            balance_usdc : 0x2::balance::zero<USDC>(),
            balance_usdt : 0x2::coin::into_balance<USDT>(arg2),
            balance_sui  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = GiftCardCreated{
            token_id  : 0x2::object::id<GiftCard>(&v1),
            recipient : arg1,
            amount    : v0,
            coin_type : 0x1::string::utf8(b"USDT"),
            uri       : 0x1::string::from_ascii(0x2::url::inner_url(&v1.metadata_uri)),
            message   : v1.message,
        };
        0x2::event::emit<GiftCardCreated>(v2);
        0x2::transfer::transfer<GiftCard>(v1, arg1);
    }

    public fun get_gift_card_info(arg0: &GiftCard) : (u64, 0x1::string::String, bool, 0x1::string::String, 0x1::string::String) {
        (arg0.amount, arg0.coin_type, arg0.redeemed, arg0.message, 0x1::string::from_ascii(0x2::url::inner_url(&arg0.metadata_uri)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GiftCardCollection{
            id               : 0x2::object::new(arg0),
            token_id_counter : 0,
            admin            : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<GiftCardCollection>(v0);
    }

    public entry fun redeem_gift_card_sui(arg0: &mut GiftCard, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.redeemed, 2);
        assert!(arg0.coin_type == 0x1::string::utf8(b"SUI"), 3);
        arg0.redeemed = true;
        let v0 = GiftCardRedeemed{
            token_id  : 0x2::object::id<GiftCard>(arg0),
            redeemer  : 0x2::tx_context::sender(arg1),
            amount    : arg0.amount,
            coin_type : arg0.coin_type,
        };
        0x2::event::emit<GiftCardRedeemed>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance_sui), arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun redeem_gift_card_usdc(arg0: &mut GiftCard, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.redeemed, 2);
        assert!(arg0.coin_type == 0x1::string::utf8(b"USDC"), 3);
        arg0.redeemed = true;
        let v0 = GiftCardRedeemed{
            token_id  : 0x2::object::id<GiftCard>(arg0),
            redeemer  : 0x2::tx_context::sender(arg1),
            amount    : arg0.amount,
            coin_type : arg0.coin_type,
        };
        0x2::event::emit<GiftCardRedeemed>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::from_balance<USDC>(0x2::balance::withdraw_all<USDC>(&mut arg0.balance_usdc), arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun redeem_gift_card_usdt(arg0: &mut GiftCard, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.redeemed, 2);
        assert!(arg0.coin_type == 0x1::string::utf8(b"USDT"), 3);
        arg0.redeemed = true;
        let v0 = GiftCardRedeemed{
            token_id  : 0x2::object::id<GiftCard>(arg0),
            redeemer  : 0x2::tx_context::sender(arg1),
            amount    : arg0.amount,
            coin_type : arg0.coin_type,
        };
        0x2::event::emit<GiftCardRedeemed>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::from_balance<USDT>(0x2::balance::withdraw_all<USDT>(&mut arg0.balance_usdt), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

