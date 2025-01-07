module 0x6a4f746ad9207af06784ce5df6c0d95ca643d146bbfd8a6d27a2f75fb17de019::casui {
    struct CASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASUI>(arg0, 6, b"CASUI", b"CAPO \" The Mafia on Sui \"", b"I'm gonna make him an offer he can't refuse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9628_908683da30.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

