module 0x615434b1fc5a8fd975e5801a6943a6515f7297b8b1d741c1c6f3a29bf13743b3::popsui {
    struct POPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPSUI>(arg0, 6, b"POPSUI", b"Popsui the cat", b"Popsui the cat pops!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3043_3e85596c8f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

