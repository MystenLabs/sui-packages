module 0x11c2d9f9e7a154811f556e81e6c3e8dcbb9b2c96645312a4e90ba8a242606129::mzb {
    struct MZB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MZB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MZB>(arg0, 9, b"MZB", b"Zuckerberg", b"Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38952670-06b6-44f0-8668-f061e9a8ece7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MZB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MZB>>(v1);
    }

    // decompiled from Move bytecode v6
}

