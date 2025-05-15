module 0xbb76deac1de701a6cf4879aa1af94000afa40d112f25dc9dd0753d5411e7d5d4::boob {
    struct BOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOB>(arg0, 6, b"BOOB", b"BOOB SUI", b"Boob is an alien species that loves to play in the water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibcjcbyns3h63fcc4cespzgsbjicagwmkhzifchaitviugin6jv7a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

