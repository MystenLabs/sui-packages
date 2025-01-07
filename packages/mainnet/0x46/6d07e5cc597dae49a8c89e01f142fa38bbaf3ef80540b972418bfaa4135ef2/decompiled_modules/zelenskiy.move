module 0x466d07e5cc597dae49a8c89e01f142fa38bbaf3ef80540b972418bfaa4135ef2::zelenskiy {
    struct ZELENSKIY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZELENSKIY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZELENSKIY>(arg0, 9, b"ZELENSKIY", b"Zelensky ", b"Mem-token of president of Ukraine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d0e3135-d0e5-4700-a93b-f5c137a57d6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZELENSKIY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZELENSKIY>>(v1);
    }

    // decompiled from Move bytecode v6
}

