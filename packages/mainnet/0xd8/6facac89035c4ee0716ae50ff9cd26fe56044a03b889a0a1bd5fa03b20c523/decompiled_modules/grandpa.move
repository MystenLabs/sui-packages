module 0xd86facac89035c4ee0716ae50ff9cd26fe56044a03b889a0a1bd5fa03b20c523::grandpa {
    struct GRANDPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRANDPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRANDPA>(arg0, 6, b"GRANDPA", b"Sui Grandpa", b"GRANDPA, The Sui Grandpa. The wise elder of the Sui Network, he's seen it all and knows the ropes. With years of experience, he's here to guide you through the chaos of crypto like a true OG. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/PP_56e34e6349.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRANDPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRANDPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

