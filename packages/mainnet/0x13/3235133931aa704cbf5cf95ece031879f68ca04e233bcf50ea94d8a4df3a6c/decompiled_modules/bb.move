module 0x133235133931aa704cbf5cf95ece031879f68ca04e233bcf50ea94d8a4df3a6c::bb {
    struct BB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB>(arg0, 9, b"BB", b"Blu Blood", b"The Blue Alien here to suck up all the liquidity all for the moon... get it?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1b612e29922e46061c16dc14813bfbe9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

