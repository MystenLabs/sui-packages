module 0x91e92fd21c0b2f27ad13a323c3ef61ad699eec349b00f9c8ba7790bbbafa8a69::osuiwott {
    struct OSUIWOTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSUIWOTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSUIWOTT>(arg0, 6, b"OSUIWOTT", b"Osuiwott Pokemon", b"$OSUIWOTT is a water type pokemon, looking for a catch on SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaw4nxpzypdt72k2u7uga7wwyye6zvspwqibo37a2dmmv6yw3unby")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSUIWOTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OSUIWOTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

