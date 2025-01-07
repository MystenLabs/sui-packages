module 0xf7856324de48d11954066eb479c334e1bed15d6ea365ba1d723518dd55fe28b2::koal {
    struct KOAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOAL>(arg0, 9, b"KOAL", b"LazyKoala", b" For the slow and steady investor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2717b84e-a487-4c1d-b423-b3b22ff785d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

