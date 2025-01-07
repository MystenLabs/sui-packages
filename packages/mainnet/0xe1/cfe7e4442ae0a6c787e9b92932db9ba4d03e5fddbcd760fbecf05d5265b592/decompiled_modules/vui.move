module 0xe1cfe7e4442ae0a6c787e9b92932db9ba4d03e5fddbcd760fbecf05d5265b592::vui {
    struct VUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUI>(arg0, 6, b"VUI", b"VUNDIO ON SUI", b"Start to manage your collectibles on SUI Network. VUNDIO's sleek design and user-friendly features make the experience enjoyable and efficient.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_26_23_16_48_5af5974d3b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

