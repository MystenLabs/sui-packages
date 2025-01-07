module 0x33965f0e22bf799198137680527d9fed248ad3bb946fdafc854f1eb72f679e2e::GildedVentHardHat {
    struct GILDEDVENTHARDHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GILDEDVENTHARDHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GILDEDVENTHARDHAT>(arg0, 0, b"COS", b"Gilded Vent HardHat", b"Awash in volcano steam... but you can climb so much higher...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Gilded_Vent_HardHat.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GILDEDVENTHARDHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GILDEDVENTHARDHAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

