module 0x41a8cdaf8c187666fb7a62ae18b632a800a24b2b2cf4d88a14e9a5ba7a34ee29::hfs {
    struct HFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFS>(arg0, 6, b"HFS", b"Hunting Field Sui", b"Emerging lawn mowing mini game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lovepik_grass_material_png_image_400181216_wh1200_6fb40689cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

