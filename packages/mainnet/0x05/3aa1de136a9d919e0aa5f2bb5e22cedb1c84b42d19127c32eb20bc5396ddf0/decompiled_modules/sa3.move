module 0x53aa1de136a9d919e0aa5f2bb5e22cedb1c84b42d19127c32eb20bc5396ddf0::sa3 {
    struct SA3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SA3>(arg0, 9, b"SA3", b"TAO LA MAN", b"SA3 token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf4b1165-3183-4624-8899-3de6238dcdac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SA3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SA3>>(v1);
    }

    // decompiled from Move bytecode v6
}

