module 0xdc64ace08ab7ea947dba96903ed77950aed831a75225d08fb4e6d6a87f504117::AHugfortheSeason {
    struct AHUGFORTHESEASON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHUGFORTHESEASON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHUGFORTHESEASON>(arg0, 0, b"COS", b"A Hug for the Season", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_A_Hug_for_the_Season.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHUGFORTHESEASON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHUGFORTHESEASON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

