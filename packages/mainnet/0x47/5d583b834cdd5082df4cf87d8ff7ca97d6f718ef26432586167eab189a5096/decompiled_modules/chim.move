module 0x475d583b834cdd5082df4cf87d8ff7ca97d6f718ef26432586167eab189a5096::chim {
    struct CHIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIM>(arg0, 6, b"CHIM", b"Chim SUI", b"$CHIM is here to bring happiness and good vibes to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigy6skvmgnjcscwcs3oye4nzh4jjcartpeppx2w3c5o2qo2ieyrla")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHIM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

