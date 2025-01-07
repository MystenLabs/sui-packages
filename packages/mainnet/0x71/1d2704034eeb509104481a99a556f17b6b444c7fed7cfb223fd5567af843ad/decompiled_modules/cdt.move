module 0x711d2704034eeb509104481a99a556f17b6b444c7fed7cfb223fd5567af843ad::cdt {
    struct CDT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CDT>, arg1: 0x2::coin::Coin<CDT>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin_signer(arg2);
        0x2::coin::burn<CDT>(arg0, arg1);
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<CDT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDT>>(arg0, arg1);
    }

    fun assert_admin_signer(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xfa800cc4e6d28d935afafe87c69a71eeb7a889cbb89d819da10efdda851f81ed, 65540);
    }

    fun create_and_mint(arg0: CDT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<CDT>, 0x2::coin::CoinMetadata<CDT>) {
        let (v0, v1) = create_coin(arg0, arg2);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, arg1, arg2);
        (v2, v1)
    }

    fun create_coin(arg0: CDT, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<CDT>, 0x2::coin::CoinMetadata<CDT>) {
        0x2::coin::create_currency<CDT>(arg0, 6, b"CDT", b"CheckDot", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://checkdot.io/token-256x256.png"))), arg1)
    }

    fun init(arg0: CDT, arg1: &mut 0x2::tx_context::TxContext) {
        assert_admin_signer(arg1);
        let (v0, v1) = create_and_mint(arg0, 9897808000000, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CDT>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CDT>>(v0);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<CDT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CDT>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

