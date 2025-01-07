module 0x50e39924e5e5291c0f91add588f522b4fdf3e87c674a2c4b4ef1e31ce929cae5::suipengsui {
    struct SUIPENGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPENGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPENGSUI>(arg0, 6, b"SUIPENGSUI", b"SUI PENG", b"the most famous penguin on sui network!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_180720462_631993a66f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPENGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPENGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

