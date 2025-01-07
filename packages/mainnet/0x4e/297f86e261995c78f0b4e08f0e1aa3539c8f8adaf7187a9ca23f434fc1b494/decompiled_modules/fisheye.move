module 0x4e297f86e261995c78f0b4e08f0e1aa3539c8f8adaf7187a9ca23f434fc1b494::fisheye {
    struct FISHEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHEYE>(arg0, 6, b"FISHEYE", b"Fish Eye Sui", x"4669736820457965206f6e2053554920436861696e20697320612070726f6a6563742074686174206272696e677320616e20616d617a696e6720657870657269656e636520696e746f2074686520626c6f636b636861696e20776f726c64207468726f7567682074686520756e69717565207065727370656374697665206f6620756e6465727761746572206c6966650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xxx_7c46304018_0a9be48e38.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

