module 0x283d1a63357ae9947e7b48d190bc81d55895554b8c4c48b1468435d3200b26b1::dxy6900 {
    struct DXY6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXY6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXY6900>(arg0, 6, b"DXY6900", b"US DEGEN INDEX 6900", b"Let the community win!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6051_28ff5ab9f0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXY6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DXY6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

