module 0x9b46fd26a636474f6eab9b44176f886719f69a5e943e66613264b49b3147109::otr {
    struct OTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTR>(arg0, 6, b"OTR", b"otter", b"just meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/992bdff6384eec4bdc1a07ea3d5e7b59_removebg_preview_5b10f10e1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

