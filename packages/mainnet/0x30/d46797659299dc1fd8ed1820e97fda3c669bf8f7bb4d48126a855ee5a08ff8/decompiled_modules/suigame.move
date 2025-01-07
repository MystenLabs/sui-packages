module 0x30d46797659299dc1fd8ed1820e97fda3c669bf8f7bb4d48126a855ee5a08ff8::suigame {
    struct SUIGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAME>(arg0, 9, b"SUIGAME", b"M2PD", b"Have a beautiful day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/n832k9F")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGAME>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

