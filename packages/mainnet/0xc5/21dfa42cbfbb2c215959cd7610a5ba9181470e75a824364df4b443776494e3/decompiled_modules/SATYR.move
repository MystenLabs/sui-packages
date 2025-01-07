module 0xc521dfa42cbfbb2c215959cd7610a5ba9181470e75a824364df4b443776494e3::SATYR {
    struct SATYR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATYR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATYR>(arg0, 9, b"SATYR", b"Satyr big stepper", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/946/938/large/nick-bray-satyr.jpg?1728989281")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATYR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SATYR>>(0x2::coin::mint<SATYR>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SATYR>>(v2);
    }

    // decompiled from Move bytecode v6
}

