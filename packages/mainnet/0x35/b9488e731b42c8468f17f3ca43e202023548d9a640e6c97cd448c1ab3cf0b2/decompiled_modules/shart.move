module 0x35b9488e731b42c8468f17f3ca43e202023548d9a640e6c97cd448c1ab3cf0b2::shart {
    struct SHART has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHART>(arg0, 6, b"SHART", b"SHARTCOIN", b"Welcome to the worlds first cryptocurrency backed by beans, dreams and digestive extremes. Born during times of panic, propelled by pressure, and celebrated in silence. Its only natural the water chain has the wet fart.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiez24u33kpejr4mrkrpznnhigqfsvjjdvn3vfmk5twptnh5ansv3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHART>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

