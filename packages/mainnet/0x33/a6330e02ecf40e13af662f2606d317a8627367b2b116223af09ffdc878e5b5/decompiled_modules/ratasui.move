module 0x33a6330e02ecf40e13af662f2606d317a8627367b2b116223af09ffdc878e5b5::ratasui {
    struct RATASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATASUI>(arg0, 6, b"RATASUI", b"Ratasui", b"We know, you know that we know that you know that this is a winner so bag your RATASUI before there is no more cheese left for you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ratasui_595815b4ae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

