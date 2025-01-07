module 0x51dfd1a0203e102a4a8350eee58a8ecb4a9a70f984c847013179170956d3de3a::suisui {
    struct SUISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUI>(arg0, 9, b"Suisui", b"Testdryve8", b"None", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISUI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUI>>(v2, @0x838768f6f87d4fbc2e13657c4574ec01be6283c7a63b40bec3e40d521d980c97);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

