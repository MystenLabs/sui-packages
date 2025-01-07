module 0x2bc14cccb45859f6fe3fe81299f80bc77bede47463992e4f01b746eae663fabf::ROOT {
    struct ROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOT>(arg0, 9, b"ROOT", b"Rootlets", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rootlets_812a2b6180.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ROOT>>(0x2::coin::mint<ROOT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ROOT>>(v2);
    }

    // decompiled from Move bytecode v6
}

