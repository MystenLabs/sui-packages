module 0x2a59749edc273a2054da6b56bcd8b33c771ff3b4236b98fcb5e6b042009e1c75::OBBONTHECOBB {
    struct OBBONTHECOBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBBONTHECOBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBBONTHECOBB>(arg0, 0, b"COS", b"OBB ON THE COBB", b"Limited-edition Aurahma swag from the Exclusive Battle Prototype event held in May 2023-the first playtesting experience for our Founding StarGarden holders-featuring a case of mistaken identity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/OBB_ON_THE_COBB.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBBONTHECOBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBBONTHECOBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

