module 0x1a3b9f857ceb2b24dc0cba01c76cae0907a203445e3cd9227bfaf3806733b358::zet {
    struct ZET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZET>(arg0, 9, b"ZET", b"Zcoin", b"This token brings power from God", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e80a20e9-500e-404e-aff1-19ad94aeeedd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZET>>(v1);
    }

    // decompiled from Move bytecode v6
}

