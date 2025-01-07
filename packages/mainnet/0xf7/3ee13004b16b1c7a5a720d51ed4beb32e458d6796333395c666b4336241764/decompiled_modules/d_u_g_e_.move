module 0xf73ee13004b16b1c7a5a720d51ed4beb32e458d6796333395c666b4336241764::d_u_g_e_ {
    struct D_U_G_E_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: D_U_G_E_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D_U_G_E_>(arg0, 9, b"D_U_G_E_", b"DeUvGuvEff", b"Deeprtmt Uv Guv Efficacy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/533b030b-b0f9-49d6-9210-1675b67f3f7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D_U_G_E_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D_U_G_E_>>(v1);
    }

    // decompiled from Move bytecode v6
}

