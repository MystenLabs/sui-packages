module 0x9cb4862782443093ad837443c5162a183e05305856a261fdd41d63b79b99d0a6::spe {
    struct SPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPE>(arg0, 9, b"SPE", b"Pure Speculation", b"If you speculate about something, you make guesses about its nature or identity, or about what might happen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JYx78Yb.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

