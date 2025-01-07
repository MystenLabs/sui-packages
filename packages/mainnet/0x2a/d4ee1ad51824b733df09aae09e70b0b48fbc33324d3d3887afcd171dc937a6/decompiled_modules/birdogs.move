module 0x2ad4ee1ad51824b733df09aae09e70b0b48fbc33324d3d3887afcd171dc937a6::birdogs {
    struct BIRDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDOGS>(arg0, 6, b"BIRDOGS", b"BirdDogsOnSui", b"$BIRDDOGS IS A MEME COIN ON SUI BLOCKCHAIN WITH NEW FEATURE AND UTILITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000145_5f74ed6b15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

