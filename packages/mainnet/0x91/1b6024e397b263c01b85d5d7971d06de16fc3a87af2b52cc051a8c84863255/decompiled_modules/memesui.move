module 0x911b6024e397b263c01b85d5d7971d06de16fc3a87af2b52cc051a8c84863255::memesui {
    struct MEMESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMESUI>(arg0, 6, b"MEMESUI", b"MEME SUI", b"WHO IS BEHIND THE MASK?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dubo_fwog_gm_022fd48f91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

