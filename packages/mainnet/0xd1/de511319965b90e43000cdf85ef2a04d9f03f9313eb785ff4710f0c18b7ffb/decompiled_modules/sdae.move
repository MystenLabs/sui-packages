module 0xd1de511319965b90e43000cdf85ef2a04d9f03f9313eb785ff4710f0c18b7ffb::sdae {
    struct SDAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDAE>(arg0, 6, b"SDAE", b"Suindae", b"Sui Sprinkled Smiles the more you scoop the Suier the delight", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeicrd2e4maev2rzuqew7ia5l7frtydmn5mtqeqo7cwtpgbeglq3nvu.ipfs.w3s.link/on_of_one_Vanilla_Sundae.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDAE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDAE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

