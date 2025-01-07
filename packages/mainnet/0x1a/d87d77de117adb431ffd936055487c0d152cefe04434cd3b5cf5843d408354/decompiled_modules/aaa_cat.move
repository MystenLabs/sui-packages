module 0x1ad87d77de117adb431ffd936055487c0d152cefe04434cd3b5cf5843d408354::aaa_cat {
    struct AAA_CAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AAA_CAT>, arg1: 0x2::coin::Coin<AAA_CAT>) {
        0x2::coin::burn<AAA_CAT>(arg0, arg1);
    }

    fun init(arg0: AAA_CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA_CAT>(arg0, 9, b"AAA", b"aaa cat", b"TOKEN_DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4995_cfd6177d03.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAA_CAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA_CAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AAA_CAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AAA_CAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

