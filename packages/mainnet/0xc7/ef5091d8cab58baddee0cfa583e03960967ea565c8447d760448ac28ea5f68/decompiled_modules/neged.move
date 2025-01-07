module 0xc7ef5091d8cab58baddee0cfa583e03960967ea565c8447d760448ac28ea5f68::neged {
    struct NEGED has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEGED>(arg0, 9, b"NEGED", b"DEGEN", b"Let's have it on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/106ea616-d308-4306-b84b-240df5078aad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEGED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEGED>>(v1);
    }

    // decompiled from Move bytecode v6
}

