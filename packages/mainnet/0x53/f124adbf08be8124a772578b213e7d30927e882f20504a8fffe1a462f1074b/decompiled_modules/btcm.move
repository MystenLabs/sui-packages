module 0x53f124adbf08be8124a772578b213e7d30927e882f20504a8fffe1a462f1074b::btcm {
    struct BTCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCM>(arg0, 9, b"BTCM", b"BTCMeMe", b"Fuk crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aae24e53-536b-41be-b767-42b288874782.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

