module 0x396891dc682a437040782030aab6d18ce4a0f187a386c3efe00a052a145e159d::kaki {
    struct KAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKI>(arg0, 9, b"KAKI", b"Kakigra ", b"Advocate for decent dressing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/141dafc8-bb38-44a2-86f6-95e9c1d88118.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

