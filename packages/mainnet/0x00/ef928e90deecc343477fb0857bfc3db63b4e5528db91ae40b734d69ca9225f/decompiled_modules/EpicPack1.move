module 0xef928e90deecc343477fb0857bfc3db63b4e5528db91ae40b734d69ca9225f::EpicPack1 {
    struct EPICPACK1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPICPACK1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPICPACK1>(arg0, 0, b"PACK", b"Epic Pack 1", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Diving_Petals.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EPICPACK1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPICPACK1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

