module 0xc594225a8b1fd86e27f54c1e277e6a465d1bf896c2c0e4c281872bb91f8b33d4::shui {
    struct SHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUI>(arg0, 6, b"SHUI", x"507572652057617465722028e6b0b42053687569efbc89", x"4f6820507572652057617465722028e6b0b42053687569292c0a46726f6d206d6f756e7461696e207065616b7320796f7520736f66746c7920676c6964652c0a412073696c7665722073747265616d206f6e206e6174757265e280997320726964652e0a596f7572206d75726d7572732064616e636520696e20726976657273e280992073776565702c0a536563726574732068656c6420696e2063757272656e747320646565702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730971429533.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

