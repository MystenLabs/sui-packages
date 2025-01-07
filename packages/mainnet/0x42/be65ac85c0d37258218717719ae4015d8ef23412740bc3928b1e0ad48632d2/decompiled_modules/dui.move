module 0x42be65ac85c0d37258218717719ae4015d8ef23412740bc3928b1e0ad48632d2::dui {
    struct DUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUI>(arg0, 6, b"DUI", b"Doge Under Influence", b"Just blame the dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_2_8e253fc345.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

