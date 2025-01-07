module 0xfc708d9115a36f31a93522624c147dbf0e8a04cce626a1b662e7e1c18a94a96d::alf {
    struct ALF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALF>(arg0, 9, b"ALF", b"Alf", b"We love aliens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f93c8fa1-11a4-4022-8667-4e523eb69f85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALF>>(v1);
    }

    // decompiled from Move bytecode v6
}

