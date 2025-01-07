module 0xde594530f0c849a384f9031aaf744143eba2e195a3a5024fc59cee84b4005c02::FIRE {
    struct FIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRE>(arg0, 2, b"FIRE", b"Fire on Sui", b"Water and fire, two forces of nature, each powerful in its own right. Water flows gently, nourishing life, offering calm and serenity. It adapts to any shape, quietly persistent yet capable of immense strength when the tide turns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/gk19LDgZ/firesui.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIRE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIRE>(&mut v2, 1000000000000, @0xf292b762db4702889d60aab39b421f609abfdb61d56384e08c17323698b1ba57, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

