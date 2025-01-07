module 0x315da91d69dd845c5117da2db3514549601df1a43ef3d6a6895b44b4d4f4fcbc::chm {
    struct CHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHM>(arg0, 6, b"CHM", b"Cheems Cheems", b"cheems cheems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cheems_meme_d0143a3fdf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHM>>(v1);
    }

    // decompiled from Move bytecode v6
}

