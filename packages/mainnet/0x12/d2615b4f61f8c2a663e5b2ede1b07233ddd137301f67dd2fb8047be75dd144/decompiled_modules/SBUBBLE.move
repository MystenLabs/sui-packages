module 0x12d2615b4f61f8c2a663e5b2ede1b07233ddd137301f67dd2fb8047be75dd144::SBUBBLE {
    struct SBUBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBUBBLE>(arg0, 9, b"SBUBBLE", b"Bubble on Sui", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F1000037492_ff2ecb5b4f.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBUBBLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SBUBBLE>>(0x2::coin::mint<SBUBBLE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SBUBBLE>>(v2);
    }

    // decompiled from Move bytecode v6
}

