module 0xb69b1a0fc762708f8cb101bc1813b60e32ecb702fa0ca72df4c6badc45dc57b9::igomeow {
    struct IGOMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGOMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGOMEOW>(arg0, 6, b"IGoMeow", b"I Go Meow on SUI", x"49476f4d656f77206f6e2053554920206f6666696369616c207477697474657220200a5468652062656c6f7665642073696e67696e6720636174206e6f77206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L_Co_Oo3yh_400x400_323853030e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGOMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IGOMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

