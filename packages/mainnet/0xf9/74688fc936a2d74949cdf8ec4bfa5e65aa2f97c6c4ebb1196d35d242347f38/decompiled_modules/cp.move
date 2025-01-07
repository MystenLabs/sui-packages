module 0xf974688fc936a2d74949cdf8ec4bfa5e65aa2f97c6c4ebb1196d35d242347f38::cp {
    struct CP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CP>(arg0, 9, b"CP", b"Computer", x"4dc3a1792074c3ad6e68", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7eb16447-12e3-41e4-b53f-28bc8eec68ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CP>>(v1);
    }

    // decompiled from Move bytecode v6
}

