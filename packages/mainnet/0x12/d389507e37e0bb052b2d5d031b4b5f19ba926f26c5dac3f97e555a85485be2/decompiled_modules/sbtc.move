module 0x12d389507e37e0bb052b2d5d031b4b5f19ba926f26c5dac3f97e555a85485be2::sbtc {
    struct SBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBTC>(arg0, 6, b"SBTC", b"Sui BTC", b"$BTC - THE BITCOIN TRADER CAT , WHO LIKES TO SMOKE WEED AND DRINK BEER, IT CAN BE SEEN BY HIS FAT ASS, STUPID NOOB FACE, PUPPET FARM CAT BUS IS HERE TO ROCK !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_18_14_08_24_08bb9d6f43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

