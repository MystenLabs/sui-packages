module 0x6fb57ccf58ab69e83ea420fd1b7a2337898557bc5926eddf89da0fb0b6367d9e::curut {
    struct CURUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CURUT>(arg0, 9, b"CURUT", b"CURUT SAYA", b"CURUT SAYA JP LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0c13093-0e30-4a68-bfe0-c1e2bb461ebd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CURUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

