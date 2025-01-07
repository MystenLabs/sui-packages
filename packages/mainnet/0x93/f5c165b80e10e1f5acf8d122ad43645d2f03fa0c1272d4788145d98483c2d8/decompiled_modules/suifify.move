module 0x93f5c165b80e10e1f5acf8d122ad43645d2f03fa0c1272d4788145d98483c2d8::suifify {
    struct SUIFIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFIFY>(arg0, 6, b"SUIFIFY", b"Suifify App", x"537575696669667920697320536f756e64204d6f6e65792e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T145104_066_554885878f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFIFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

