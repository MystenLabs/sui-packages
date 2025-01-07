module 0xdafced9cee0e44ccad31553f28bb609d1a12f407f33c8bae8486cb1626007cc8::lg {
    struct LG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LG>(arg0, 9, b"LG", b"Legend", b"a Legned", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e821697-f431-4915-939d-e47a03a1d71a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LG>>(v1);
    }

    // decompiled from Move bytecode v6
}

