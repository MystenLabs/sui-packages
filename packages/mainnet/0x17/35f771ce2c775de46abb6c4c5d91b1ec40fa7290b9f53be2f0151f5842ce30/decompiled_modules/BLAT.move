module 0x1735f771ce2c775de46abb6c4c5d91b1ec40fa7290b9f53be2f0151f5842ce30::BLAT {
    struct BLAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLAT>, arg1: 0x2::coin::Coin<BLAT>, arg2: &mut 0x2::tx_context::TxContext) {
        is_admin_signer(arg2);
        0x2::coin::burn<BLAT>(arg0, arg1);
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<BLAT>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAT>>(arg0, arg1);
    }

    fun create_and_mint(arg0: BLAT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<BLAT>, 0x2::coin::CoinMetadata<BLAT>) {
        let (v0, v1) = create_blat(arg0, arg2);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, arg1, arg2);
        (v2, v1)
    }

    fun create_blat(arg0: BLAT, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<BLAT>, 0x2::coin::CoinMetadata<BLAT>) {
        0x2::coin::create_currency<BLAT>(arg0, 9, b"BLAT", b"BeLaunch Token", b"The launchpad platform is safe and secure for everyone!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://belaunch.s3.ap-southeast-1.amazonaws.com/media/images/blat.svg"))), arg1)
    }

    fun init(arg0: BLAT, arg1: &mut 0x2::tx_context::TxContext) {
        is_admin_signer(arg1);
        let (v0, v1) = create_and_mint(arg0, 100000000000000000, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLAT>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BLAT>>(v0);
    }

    fun is_admin_signer(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x1c30b57db84d10c7d608c6adeadff8b82b1efbdae12c8406ff20ae6f0588002a, 65540);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLAT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BLAT>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

