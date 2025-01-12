module 0xa0d132c3fdd91aaa8ef9ec04ed6c7db7d2317259fc9bafda187d647914a345b7::bengy {
    struct BENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENGY>(arg0, 9, b"BENGY", b"BENGY on SUI", x"48492c20494d202442454e4759210d0a0d0a50454f504c452054454c4c204d452049204c4f4f4b204c494b4520504550452e20492054454c4c205448454d20494d20412050454e4755494e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY9xGoFHZ7FsPJyRnfxuK7sJvVeWaoHRU5mjzdYADuTAA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BENGY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BENGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENGY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

