module 0x90f9eb95f62d31fbe2179313547e360db86d88d2399103a94286291b63f469ba::xo {
    struct XO has drop {
        dummy_field: bool,
    }

    struct WrappedTreasury<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    fun init(arg0: XO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XO>(arg0, 9, b"XO", b"Xociety Token", b"Base currency for the Xociety ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.xociety.io/assets/xo/xo_token.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XO>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint_and_transfer_to_sender(v3, v4, arg1);
        wrap_and_freeze_treasury<XO>(v2, arg1);
    }

    fun mint_and_transfer_to_sender(arg0: &mut 0x2::coin::TreasuryCap<XO>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XO>>(0x2::coin::mint<XO>(arg0, 5000000000000000000, arg2), arg1);
    }

    fun wrap_and_freeze_treasury<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut v0, v1, arg0);
        let v2 = WrappedTreasury<T0>{id: v0};
        0x2::transfer::freeze_object<WrappedTreasury<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

