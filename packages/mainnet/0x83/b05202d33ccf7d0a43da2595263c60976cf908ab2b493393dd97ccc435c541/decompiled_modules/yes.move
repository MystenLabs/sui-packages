module 0x83b05202d33ccf7d0a43da2595263c60976cf908ab2b493393dd97ccc435c541::yes {
    struct YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YES>(arg0, 6, b"Yes", b"69", x"59696e20616e642059616e67200a363920616c6c207468652074696d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/main_qimg_db0ff9ae04832ce80934589a16d943a6_lq_465d88cf48.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YES>>(v1);
    }

    // decompiled from Move bytecode v6
}

