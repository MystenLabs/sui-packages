module 0x944bc923d46f094994a5a81e678cd98c2ff27e015ccef95603012d356d6ca82a::sadas {
    struct SADAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADAS>(arg0, 6, b"SADAS", b"test", b"asdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifjct4gittuouzjrroo2gelh4upsqmyi6lk3qnhjec2by6mpjl6pe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SADAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

