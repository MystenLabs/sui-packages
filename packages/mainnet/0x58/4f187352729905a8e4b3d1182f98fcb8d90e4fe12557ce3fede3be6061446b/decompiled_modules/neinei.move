module 0x584f187352729905a8e4b3d1182f98fcb8d90e4fe12557ce3fede3be6061446b::neinei {
    struct NEINEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEINEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEINEI>(arg0, 6, b"NEINEI", b"Chinese NEIRO", b"Get ready to ride the dragon dog Neiro!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc_p_VD_Mt_400x400_44789703b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEINEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEINEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

