module 0x2544932b64db43640091018a3bab4ba456f4df111e29b34b9705b39a36c507bc::rttt {
    struct RTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTTT>(arg0, 6, b"RTTT", b"ttt", b"TTTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_removebg_preview_17_502aeb06c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

