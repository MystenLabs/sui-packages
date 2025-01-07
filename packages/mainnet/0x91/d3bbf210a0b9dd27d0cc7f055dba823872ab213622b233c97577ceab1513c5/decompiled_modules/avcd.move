module 0x91d3bbf210a0b9dd27d0cc7f055dba823872ab213622b233c97577ceab1513c5::avcd {
    struct AVCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVCD>(arg0, 6, b"AVCD", b"AVCC", b"AVC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moonlitebot_x_rachop_0a6cd84da7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

