module 0xf0c034c42b659ad56975dde8c828ddc6f6de267a11ee3dcb9bb6139a3b011816::adogeai {
    struct ADOGEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADOGEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADOGEAI>(arg0, 6, b"ADOGEAI", b"DOGERMAN", b"A DOG that don't BARK but HACK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifjct4gittuouzjrroo2gelh4upsqmyi6lk3qnhjec2by6mpjl6pe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADOGEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADOGEAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

