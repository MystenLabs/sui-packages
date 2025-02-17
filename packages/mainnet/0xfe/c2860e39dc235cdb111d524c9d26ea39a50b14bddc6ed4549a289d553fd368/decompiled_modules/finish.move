module 0xfec2860e39dc235cdb111d524c9d26ea39a50b14bddc6ed4549a289d553fd368::finish {
    struct FINISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINISH>(arg0, 7, b"finish", b"finish", b"finish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"finish")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FINISH>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FINISH>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FINISH>>(v2);
    }

    // decompiled from Move bytecode v6
}

