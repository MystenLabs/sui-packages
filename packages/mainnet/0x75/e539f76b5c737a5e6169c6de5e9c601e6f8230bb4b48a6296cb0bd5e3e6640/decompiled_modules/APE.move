module 0x75e539f76b5c737a5e6169c6de5e9c601e6f8230bb4b48a6296cb0bd5e3e6640::APE {
    struct APE has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<APE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<APE>>(0x2::coin::mint<APE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 9, b"APE", b"ApeSuiCoin", b"ApeSuiCoin is an $SUI governance and utility token used to empower a decentralized community building at the forefront of web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1654039490875523072/L7ehlsi1_400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::coin::mint_and_transfer<APE>(&mut v2, 100000000000000000, @0xbdedba87cb17d32f782b7c07a56c85fbd4223c0bac6500a7e6ece0cf0cbe4548, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APE>>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun renounce(arg0: &mut 0x2::coin::TreasuryCap<APE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<APE>>(0x2::coin::mint<APE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

