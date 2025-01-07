module 0x80859242c6d613662a3077aa1515d4e5f20810a762d85be2d19c019f5c3fe39c::RareTraitPackLVL1 {
    struct RARETRAITPACKLVL1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: RARETRAITPACKLVL1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RARETRAITPACKLVL1>(arg0, 0, b"PACK", b"Rare Trait Pack LVL 1", b"Dress up your Aurahma with Trait Packs, the perfect way to create your very own unique combination! With randomly generated traits of varying rarities, you can craft, trade and merge your way to creating a look that stands out!  This pack contains 2 random Traits. Rarity distribution: 97% Rare, 2.5% Epic, 0.5% Legendary.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Rare_Trait_Pack_LVL_1.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RARETRAITPACKLVL1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RARETRAITPACKLVL1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

