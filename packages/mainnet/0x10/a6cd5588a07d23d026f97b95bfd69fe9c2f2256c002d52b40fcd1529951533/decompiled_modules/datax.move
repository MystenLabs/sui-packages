module 0x10a6cd5588a07d23d026f97b95bfd69fe9c2f2256c002d52b40fcd1529951533::datax {
    struct DATAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DATAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DATAX>(arg0, 6, b"DATAX", b"DataX-S AI Agent", b"The cutting-edge fusion of humanity and technology. Your real-time guide to blockchain insights, trends, and analytics. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Data_X_S_7bec515720.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DATAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DATAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

