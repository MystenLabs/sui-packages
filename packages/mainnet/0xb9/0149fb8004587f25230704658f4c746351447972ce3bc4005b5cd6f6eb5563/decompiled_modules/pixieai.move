module 0xb90149fb8004587f25230704658f4c746351447972ce3bc4005b5cd6f6eb5563::pixieai {
    struct PIXIEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXIEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXIEAI>(arg0, 9, b"PIXIEAI", b"Pixie AI", b"Unleash the full potential of your creativity with PixieAI. Our powerful AI generator transforms your ideas into unique, high-quality visuals effortlessly. Create, customize, and download your artwork in just a few clicks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfLbDNYsbtQEHMecwLi4FKxNszGarBrF8NhcECmGrD5T5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIXIEAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIXIEAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXIEAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

