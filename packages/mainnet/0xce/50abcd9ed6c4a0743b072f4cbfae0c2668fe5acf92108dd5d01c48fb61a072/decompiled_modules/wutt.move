module 0xce50abcd9ed6c4a0743b072f4cbfae0c2668fe5acf92108dd5d01c48fb61a072::wutt {
    struct WUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUTT>(arg0, 6, b"WUTT", b"WUTTCOIN", b"it is WUTT it is", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_b82a8d96d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

