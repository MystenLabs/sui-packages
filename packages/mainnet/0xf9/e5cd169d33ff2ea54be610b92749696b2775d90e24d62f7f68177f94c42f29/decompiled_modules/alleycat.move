module 0xf9e5cd169d33ff2ea54be610b92749696b2775d90e24d62f7f68177f94c42f29::alleycat {
    struct ALLEYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLEYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALLEYCAT>(arg0, 9, b"ALLEYCAT", b"AlleyCat", b"AlleyCat, the purr-fect cryptocurrency inspired by the classic DOS game AlleyCat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.degencdn.com/ipfs/bafybeifzyj5blpme655jdiotq3vhyim6xtkzkc4vi2s6mbczndvpjln4ou")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALLEYCAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALLEYCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLEYCAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

