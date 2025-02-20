module 0xe80b7bae14df46313dea9978d4ada9017a5b2cc4e98aa5d143987df72d31c6a5::ttg {
    struct TTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTG>(arg0, 9, b"TTG", b"Taitiko", b"Taitiko is more than a game. It's a brand, a movement and a New Era of Play.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma8AtkuWQb8HNur8XsiumcmHzmAfmr1aYCZkEsZhjXZHM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TTG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

