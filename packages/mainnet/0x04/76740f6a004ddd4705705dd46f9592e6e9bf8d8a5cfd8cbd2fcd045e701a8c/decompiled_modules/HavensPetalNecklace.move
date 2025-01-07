module 0x476740f6a004ddd4705705dd46f9592e6e9bf8d8a5cfd8cbd2fcd045e701a8c::HavensPetalNecklace {
    struct HAVENSPETALNECKLACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAVENSPETALNECKLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAVENSPETALNECKLACE>(arg0, 0, b"COS", b"Havens Petal Necklace", b"Light stains these petals... light... what became of you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Havens_Petal_Necklace.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAVENSPETALNECKLACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAVENSPETALNECKLACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

