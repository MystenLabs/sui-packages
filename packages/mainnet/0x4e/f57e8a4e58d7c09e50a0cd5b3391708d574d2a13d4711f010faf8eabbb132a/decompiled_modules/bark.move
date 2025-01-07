module 0x4ef57e8a4e58d7c09e50a0cd5b3391708d574d2a13d4711f010faf8eabbb132a::bark {
    struct BARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARK>(arg0, 6, b"BARK", b"BarkCoin", b"BarkCoin is the ultimate meme coin, bringing the joy and charm of a playful Shiba Inu straight to your wallet! Embossed with the image of a happy dog sporting stylish sunglasses and a big, friendly grin, BarkCoin radiates positive energy and fun. The vibrant yellow and light blue background captures the essence of cheerful days, making every transaction a delightful experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/HljLtyVz5YXOwNvaKNrebSIzcDHhref9AZ6JDpYc0b8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BARK>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARK>>(v2, @0xa4816d3e4965b0bc1b2bc30039fedde0fd24ded89f95444ca239bad76f7f2b40);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

