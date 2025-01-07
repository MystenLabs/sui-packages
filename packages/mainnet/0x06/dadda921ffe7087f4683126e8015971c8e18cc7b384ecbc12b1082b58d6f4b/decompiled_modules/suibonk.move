module 0x6dadda921ffe7087f4683126e8015971c8e18cc7b384ecbc12b1082b58d6f4b::suibonk {
    struct SUIBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBONK>(arg0, 6, b"SUIBONK", b"Sui BONK!", b"suibonk.wtf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_Si_C_Wxb_YA_Ar_U34_cb8e147d87.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

