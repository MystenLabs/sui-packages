module 0x9b682fb2782c185c4e80e3574d0f1e46eb59fb181193230a04340e741a8d150d::fisherman {
    struct FISHERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHERMAN>(arg0, 6, b"FISHERMAN", b"Just a chill fisherm", x"41206669736865726d616e207769746820616e20616d626974696f6e206f66206361746368696e67207768616c6573206f6e200a40547572626f735f66696e616e63650a207c7c204c697374696e67206f6e2068747470733a2f2f6170702e747572626f732e66696e616e63652f66756e2f232f66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735805920644.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHERMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHERMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

