module 0xdb759fcb98895d4fdcadb629b50bf1cabda4d234061b06900b25862f9a6d964e::gas {
    struct GAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAS>(arg0, 6, b"GAS", b"GalaxySeed", b"\"Plant the seeds of innovation with GalaxySeed, the token for dreamers and explorers. Invest in the future of space science, collect breathtaking NFTs of galaxies and stars, and sponsor groundbreaking space technology projects. Your journey to the co", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732071368635.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

