module 0x6610e7a777ba4534545239e8ac0f3ee3df56697a7da09123d3315bf611449493::aos {
    struct AOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOS>(arg0, 6, b"Aos", b"adeniyi on steroid", b"mr olympia 2026", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiertujqjfhkmhytjbfepsjvx7akysfjvgps5gp2gbcy2j3gckafiu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

