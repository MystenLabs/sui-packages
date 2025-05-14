module 0xb704f72996e903d77d8df28d75b6c026f12dea9d05a58be0339a96434d14ac38::kokoko {
    struct KOKOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOKOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKOKO>(arg0, 6, b"KOKOKO", b"KoKoK The Roach", b"$KoKoK: the unkillable cockroach trader, built on SUI. join us https://t.me/kokok_theroach", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidv2c5qekcdoet3f33lku5msbrfrqs5f7ty5tdvi7zp6aj5zlkuc4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOKOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOKOKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

