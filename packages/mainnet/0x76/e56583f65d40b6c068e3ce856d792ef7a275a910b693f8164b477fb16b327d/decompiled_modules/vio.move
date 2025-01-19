module 0x76e56583f65d40b6c068e3ce856d792ef7a275a910b693f8164b477fb16b327d::vio {
    struct VIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIO>(arg0, 6, b"VIO", b"Vio AI", b"$VIO  revolutionizing crypto analysis, token discovery, and on-chain data intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2141_2d2a6f70fd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

