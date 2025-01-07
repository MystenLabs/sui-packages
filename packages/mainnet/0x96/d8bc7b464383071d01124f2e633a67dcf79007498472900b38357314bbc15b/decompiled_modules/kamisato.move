module 0x96d8bc7b464383071d01124f2e633a67dcf79007498472900b38357314bbc15b::kamisato {
    struct KAMISATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMISATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMISATO>(arg0, 9, b"KAMISATO", b"Ayayo", b"Kamisato ayayo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b382c9d-e719-43c0-a736-2de86a57484c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMISATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMISATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

