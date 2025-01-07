module 0x3bcab4f6a7958752c3d2bcc42f789d424b45ad9a4ff1a9b6e8965196e238bdf1::binks {
    struct BINKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINKS>(arg0, 6, b"BINKS", b"JarJar", x"4275696c64696e67207468652077616c727573206f6620636f6d70757465206f6e200a407375696e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_B_Rh_F_Ef_C_400x400_b44110ee5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

