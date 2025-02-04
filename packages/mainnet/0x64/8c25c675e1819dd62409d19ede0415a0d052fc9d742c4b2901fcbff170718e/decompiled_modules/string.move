module 0x648c25c675e1819dd62409d19ede0415a0d052fc9d742c4b2901fcbff170718e::string {
    struct STRING has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRING>(arg0, 9, b"string", b"string", b"string", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"string")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STRING>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRING>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STRING>>(v2);
    }

    // decompiled from Move bytecode v6
}

