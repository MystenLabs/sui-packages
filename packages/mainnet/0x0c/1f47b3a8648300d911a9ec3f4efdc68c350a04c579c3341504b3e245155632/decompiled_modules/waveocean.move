module 0xc1f47b3a8648300d911a9ec3f4efdc68c350a04c579c3341504b3e245155632::waveocean {
    struct WAVEOCEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEOCEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEOCEAN>(arg0, 9, b"WAVEOCEAN", b"Wave Ocean", b"New ProDuct", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8472c205-0051-4362-9221-e918920b2b06-03ED7961-A559-4521-9D48-6B845975D539.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEOCEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEOCEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

