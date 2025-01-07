module 0x88b88b18a341cd0d0b86a18a613744e05563d0b42f416cd2f0d64596c0f44c40::stash {
    struct STASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STASH>(arg0, 6, b"STASH", b"STASH SUI", b"STASHTOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fyi7y7_s_400x400_14c0f1fb95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

