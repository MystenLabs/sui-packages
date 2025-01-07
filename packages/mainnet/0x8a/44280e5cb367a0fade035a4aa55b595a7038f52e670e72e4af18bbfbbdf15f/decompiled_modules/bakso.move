module 0x8a44280e5cb367a0fade035a4aa55b595a7038f52e670e72e4af18bbfbbdf15f::bakso {
    struct BAKSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKSO>(arg0, 9, b"BAKSO", b"Bakso Bang", b"Inspired by traditional Indonesian food, namely yummy meatballs!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27e079e0-a15c-4621-ab69-ad5bb13f647b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAKSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

