module 0x95fb3e3a018637f73b7e657ef451e4901777c1b454a43a04abdb3504483d1ff8::sdoge {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 9, b"SDOGE", b"Sui Doge", b"Introducing Sui Doge (sDOGE), the cryptocurrency that's barking up a storm in the world of decentralized finance. Inspired by the beloved Doge meme, Sui Doge brings a fresh and playful twist to the world of crypto assets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/TdHw3om.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SDOGE>(&mut v2, 210000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGE>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

