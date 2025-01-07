module 0xbee3b03e6285715bdbf91aec959a9f32faa58da03dfe2ac7735ad39a006f6fb6::muststopmurad {
    struct MUSTSTOPMURAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSTSTOPMURAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSTSTOPMURAD>(arg0, 6, b"MustStopMurad", b"Morud", b"sui murad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_14_00_08_00_8d84ee61a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSTSTOPMURAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSTSTOPMURAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

