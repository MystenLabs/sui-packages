module 0xe8f0fda90af6b6b40734d24e9faf237b08e35890d55b2490e02f6b918ebf7b18::STAR {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAR>(arg0, 6, b"STAR", b"STAR", b"1231231232131", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmY7x8DUGNRywJFTCFZ396pUe4WoV1x1KUeYJDQA2f435i")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

