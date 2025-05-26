module 0xe9be46f269eaeb959837ef9f576151ea584111b650c6bfc1745353c6f90bfc00::joint {
    struct JOINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOINT>(arg0, 6, b"JOINT", b"SUI JOINT", b"Let's smoke all together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Progetto_senza_titolo_zip_2_79e79f835e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

