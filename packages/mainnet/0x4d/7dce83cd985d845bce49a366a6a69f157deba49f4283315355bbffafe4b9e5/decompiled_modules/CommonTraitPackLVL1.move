module 0x4d7dce83cd985d845bce49a366a6a69f157deba49f4283315355bbffafe4b9e5::CommonTraitPackLVL1 {
    struct COMMONTRAITPACKLVL1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMONTRAITPACKLVL1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMONTRAITPACKLVL1>(arg0, 0, b"PACK", b"Common Trait Pack LVL 1", b"Dress up your Aurahma with Trait Packs, the perfect way to create your very own unique combination! With randomly generated traits of varying rarities, you can craft, trade and merge your way to creating a look that stands out!  This pack contains 3 random Traits. Rarity distribution: 97% Common, 2.5% Uncommon, 0.5% Rare.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Common_Trait_Pack_LVL_1.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMMONTRAITPACKLVL1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMONTRAITPACKLVL1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

