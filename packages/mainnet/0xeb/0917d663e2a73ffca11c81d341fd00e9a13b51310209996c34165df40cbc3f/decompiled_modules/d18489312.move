module 0xeb0917d663e2a73ffca11c81d341fd00e9a13b51310209996c34165df40cbc3f::d18489312 {
    struct D18489312 has drop {
        dummy_field: bool,
    }

    fun init(arg0: D18489312, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D18489312>(arg0, 18, b"D18489312", b"18 Decimal Token 1759892489312", b"Token with 18 decimals like ETH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D18489312>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D18489312>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

