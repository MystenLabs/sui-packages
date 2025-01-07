module 0xb3f53e6923284a3364252321bac8001b46915ed1ac00b1bdf4659696e28f8190::yenni {
    struct YENNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YENNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YENNI>(arg0, 6, b"YENNI", b"YENNI on SUI", b"Yenni ain't shitcoin!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/VS_Ac_E_Fv_P_400x400_3e7983bf5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YENNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YENNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

