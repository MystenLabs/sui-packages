module 0xca2a85acc8f66a3f1e4c6946362f20fac486b7d9732d2b8b96d1c0a683d2c493::pnut47 {
    struct PNUT47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT47>(arg0, 6, b"PNUT47", b"PNut47", b"pnut47.xyz . Breaking News: Trump has transformed into a squirrel  and soon, hes here to stay as one! Join the movement as Donald Trump, in full squirrel mode, is ready to shake things up in the world of crypto. All Trump supporters and squirrel enthusiasts, unite!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_04_071124_cda8862b8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUT47>>(v1);
    }

    // decompiled from Move bytecode v6
}

