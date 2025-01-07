module 0xf1783e3387391f4e907442b8b4f1e6eef2cad0be83e47e4b768b4853392a4e81::fungie {
    struct FUNGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNGIE>(arg0, 6, b"Fungie", b"Fungiesui", b"The guinness record dolphin coming to Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_Jfcve_Wg_AAI_Yl_W_f4ca641bc3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

