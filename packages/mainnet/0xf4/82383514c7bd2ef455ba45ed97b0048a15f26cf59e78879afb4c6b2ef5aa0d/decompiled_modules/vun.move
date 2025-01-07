module 0xf482383514c7bd2ef455ba45ed97b0048a15f26cf59e78879afb4c6b2ef5aa0d::vun {
    struct VUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUN>(arg0, 6, b"VUN", b"VUNDIO", b"Start to manage your collectibles on SUI Network. Vundio sleek design and user-friendly features make the experience enjoyable and efficient.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_19_51_06_5e1345c706.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

