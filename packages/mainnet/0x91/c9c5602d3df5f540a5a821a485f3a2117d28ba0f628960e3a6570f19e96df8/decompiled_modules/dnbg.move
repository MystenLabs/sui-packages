module 0x91c9c5602d3df5f540a5a821a485f3a2117d28ba0f628960e3a6570f19e96df8::dnbg {
    struct DNBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNBG>(arg0, 9, b"DNBG", b"Dont Buy", b"Dont buy guys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33a36f93-f50a-49c9-823d-923f0106a111.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

