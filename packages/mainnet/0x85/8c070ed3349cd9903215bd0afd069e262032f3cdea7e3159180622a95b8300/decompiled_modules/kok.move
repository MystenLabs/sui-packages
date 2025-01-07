module 0x858c070ed3349cd9903215bd0afd069e262032f3cdea7e3159180622a95b8300::kok {
    struct KOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOK>(arg0, 9, b"KOK", b"BANGKOK", b"BENGKOK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d518ff3-4640-4449-bba0-c8501e931863.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

