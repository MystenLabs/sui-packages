module 0x273aa5fb15a5efe60c095501a0c4848b4248ef9a5b47de1591a7bfde6d1291ab::hf {
    struct HF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HF>(arg0, 6, b"HF", b"Hopfun", x"53776170206f6e200a405375694e6574776f726b0a20666f722074686520626573742070726963652077697468207a65726f20666565732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmUdqYWffGtgH38hqcZEjiPjMtYKUKuwFba4yrDusbvowZ")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HF>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HF>(11927107724338252338, v0, v1, 0x1::string::utf8(b"https://x.com/HopAggregator"), 0x1::string::utf8(b"https://hop.ag/fun"), 0x1::string::utf8(b"https://t.me/+biKJEa8POMViNTM5"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

