module 0x98dea097c0ad25c54b66a1ae43856e0cf53bbad4aaedd07d3eef08b06f4c24a9::azk {
    struct AZK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZK>(arg0, 6, b"AZK", b"Azuki", b"AzukiAzuki", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreieqauiddyg7xz6bg3k7ehaaldtmkcfytsquknuqsyqzibahxayeu4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AZK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

