module 0x5222a42f30b60e8d92de18307f0842ceda346d20066944798f52340c605d84df::fiona {
    struct FIONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIONA>(arg0, 6, b"Fiona", b"FIONA", b"A crypto dedicated to fiona the most famous hippo and ambassador of here spicies on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9007_ffa08522f5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

