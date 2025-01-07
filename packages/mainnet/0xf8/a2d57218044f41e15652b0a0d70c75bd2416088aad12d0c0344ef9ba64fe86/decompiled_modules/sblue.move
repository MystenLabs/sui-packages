module 0xf8a2d57218044f41e15652b0a0d70c75bd2416088aad12d0c0344ef9ba64fe86::sblue {
    struct SBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLUE>(arg0, 6, b"SBLUE", b"September Blue(not jerk off)", b"https://www.youtube.com/watch?v=DvERgYyqP6o", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/8b82b9014a90f603f9a3de6c3d12b31bb051ed8e_1043fe2360.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

