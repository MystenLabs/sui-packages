module 0xe7d68f1a90d8b30150932a54711db61f816ebc9e59a4963c1ff810c7ca3740ab::kamisato {
    struct KAMISATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMISATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMISATO>(arg0, 9, b"KAMISATO", b"Ayayo", b"Kamisato ayayo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a986f200-8c31-421a-b3d2-cb0520705925.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMISATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMISATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

