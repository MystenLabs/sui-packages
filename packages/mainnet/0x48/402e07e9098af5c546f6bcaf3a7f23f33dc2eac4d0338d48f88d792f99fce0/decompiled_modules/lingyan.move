module 0x48402e07e9098af5c546f6bcaf3a7f23f33dc2eac4d0338d48f88d792f99fce0::lingyan {
    struct LINGYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINGYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINGYAN>(arg0, 6, b"LINGYAN", b"Lingyan on SUI", b"#Lingyan is a viral Chinese panda, famous for his antics and twerking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_P_Fpz1m_C_400x400_7ea5c83e21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINGYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LINGYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

