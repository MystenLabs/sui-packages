module 0x4b6e8ba739b8e613c227044ba0ed0c3c6a3bc8af899ab4db054e404336225ba::oct {
    struct OCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCT>(arg0, 6, b"OCT", b"ORCAT", b"orcat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_09_19_202410889_a8eb96de90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

