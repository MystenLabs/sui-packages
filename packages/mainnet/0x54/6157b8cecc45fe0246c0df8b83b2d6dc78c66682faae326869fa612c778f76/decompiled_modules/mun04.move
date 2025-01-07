module 0x546157b8cecc45fe0246c0df8b83b2d6dc78c66682faae326869fa612c778f76::mun04 {
    struct MUN04 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUN04, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUN04>(arg0, 9, b"MUN04", b"MunTest04", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1e9444326578a7cbb6c495993645f89cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUN04>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUN04>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

