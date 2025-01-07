module 0x8cc396be7a2e5f31a1ae204c503dcd769d0609747c9532db0bde48cc0ec0b195::TWEETERHEAD {
    struct TWEETERHEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWEETERHEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWEETERHEAD>(arg0, 9, b"TWEETERHEAD", b"Tweeterhead ", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/826/666/large/tiago-zenobini-tweeterhex-sorceress-gallery-final-13-branded-scaled.jpg?1728606458")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWEETERHEAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TWEETERHEAD>>(0x2::coin::mint<TWEETERHEAD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TWEETERHEAD>>(v2);
    }

    // decompiled from Move bytecode v6
}

