module 0xed074e34488f141e86029ca030393d9cd291a7f09dde0d530ff83ef68d174e63::SUITORO {
    struct SUITORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITORO>(arg0, 9, b"OLDGOD", b"The Old God", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/068/186/871/large/andrey-amigopaul-naydyushkin-old-god-6.jpg?1697183642")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITORO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITORO>>(0x2::coin::mint<SUITORO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUITORO>>(v2);
    }

    // decompiled from Move bytecode v6
}

