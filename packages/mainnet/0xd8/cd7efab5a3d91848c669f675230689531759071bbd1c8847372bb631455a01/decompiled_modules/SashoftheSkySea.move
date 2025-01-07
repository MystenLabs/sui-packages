module 0xd8cd7efab5a3d91848c669f675230689531759071bbd1c8847372bb631455a01::SashoftheSkySea {
    struct SASHOFTHESKYSEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASHOFTHESKYSEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASHOFTHESKYSEA>(arg0, 0, b"COS", b"Sash of the Sky-Sea", b"Left behind on a driftwood shard...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Sash_of_the_Sky-Sea.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASHOFTHESKYSEA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASHOFTHESKYSEA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

