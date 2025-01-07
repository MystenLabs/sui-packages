module 0x24caa49eba27760ec8d7090da18a16e4e84162c5f87257029da7c7c7406ec654::egb {
    struct EGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGB>(arg0, 9, b"EGB", b"Egbosionu ", b"My name is egbosionu ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e61d796-3299-4bf7-9e8b-317da6f55dbe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

