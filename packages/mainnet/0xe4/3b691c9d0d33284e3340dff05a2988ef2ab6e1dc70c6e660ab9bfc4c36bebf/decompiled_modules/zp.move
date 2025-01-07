module 0xe43b691c9d0d33284e3340dff05a2988ef2ab6e1dc70c6e660ab9bfc4c36bebf::zp {
    struct ZP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZP>(arg0, 9, b"ZP", b"Zap", b"We soaring high", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0df45480-72f3-483a-9bc2-99cfaa2922ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZP>>(v1);
    }

    // decompiled from Move bytecode v6
}

