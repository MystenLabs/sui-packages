module 0x3490bbf14a903ede6db95c891766953651c87d532a75d84ed902a20eabd9ccc1::vun {
    struct VUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VUN>(arg0, 6, b"VUN", b"VUNDIO", b"Start to manage your collectibles on SUI Network. VUNDIO's sleek design and user-friendly features make the experience enjoyable and efficient.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_19_51_06_13267a91d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

