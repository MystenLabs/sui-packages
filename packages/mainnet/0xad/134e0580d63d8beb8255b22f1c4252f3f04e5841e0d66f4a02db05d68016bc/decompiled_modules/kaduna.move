module 0xad134e0580d63d8beb8255b22f1c4252f3f04e5841e0d66f4a02db05d68016bc::kaduna {
    struct KADUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KADUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KADUNA>(arg0, 9, b"KADUNA", b"Kd", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23941a28-9993-4307-ab09-6a3b52f194f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KADUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KADUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

