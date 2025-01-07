module 0x21a5673d221d3a6429638bbc7a5bc054792251a4a885c41b7fddb5df5f98f88a::lovebirds {
    struct LOVEBIRDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVEBIRDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVEBIRDS>(arg0, 6, b"LOVEBIRDS", b"Lovebirds", b"A small bird with a big secret.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Yedk_Xln_400x400_8ad29eca16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVEBIRDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOVEBIRDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

