module 0x3f359486b8d459540406804da59ef3a62d8415e8ed5b89dce13f6d0edb92235::cumo {
    struct CUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUMO>(arg0, 6, b"CUMO", b"KumoTheCat", b"A clumsy cat has entered the chat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z_Cyh88y_J_400x400_fbb216699b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

