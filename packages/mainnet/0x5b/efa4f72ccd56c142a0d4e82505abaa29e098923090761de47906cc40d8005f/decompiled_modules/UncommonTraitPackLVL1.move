module 0x5befa4f72ccd56c142a0d4e82505abaa29e098923090761de47906cc40d8005f::UncommonTraitPackLVL1 {
    struct UNCOMMONTRAITPACKLVL1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNCOMMONTRAITPACKLVL1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNCOMMONTRAITPACKLVL1>(arg0, 0, b"PACK", b"Uncommon Trait Pack LVL 1", b"Dress up your Aurahma with Trait Packs, the perfect way to create your very own unique combination! With randomly generated traits of varying rarities, you can craft, trade and merge your way to creating a look that stands out!  This pack contains 2 random Traits. Rarity distribution: 97% Uncommon, 2.5% Rare, 0.5% Epic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Uncommon_Trait_Pack_LVL_1.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNCOMMONTRAITPACKLVL1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNCOMMONTRAITPACKLVL1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

