module 0x8a8488d6e3fd6acc34cd5a2a23a0d48128ee7cf46b51f84c4e33180026d5fb00::IFINE {
    struct IFINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IFINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IFINE>(arg0, 9, b"FINE", b"It's Fine!", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F2024_10_14_15_29_10_4c5f464c4d.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IFINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<IFINE>>(0x2::coin::mint<IFINE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IFINE>>(v2);
    }

    // decompiled from Move bytecode v6
}

