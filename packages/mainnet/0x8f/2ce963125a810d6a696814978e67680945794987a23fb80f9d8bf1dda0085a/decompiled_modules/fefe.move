module 0x8f2ce963125a810d6a696814978e67680945794987a23fb80f9d8bf1dda0085a::fefe {
    struct FEFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEFE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FEFE>(arg0, 6, b"FEFE", b"sfs", b"ffsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/9042bfec_b445_414a_a6ab_4a3167e1e7fa_47bece69ff.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FEFE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEFE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

