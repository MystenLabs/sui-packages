module 0xb700e9e6887f101e6d8aef280bd1c7975bfc09fd244ca9a4d50be85e9393b109::CommonTraitPackLVL2 {
    struct COMMONTRAITPACKLVL2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMONTRAITPACKLVL2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMMONTRAITPACKLVL2>(arg0, 0, b"PACK", b"Common Trait Pack LVL 2", b"Dress up your Aurahma with Trait Packs, the perfect way to create your very own unique combination! With randomly generated traits of varying rarities, you can craft, trade and merge your way to creating a look that stands out!  This pack contains 5 random Traits. Rarity distribution: 97% Common, 2.5% Uncommon, 0.5% Rare.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Common_Trait_Pack_LVL_2.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMMONTRAITPACKLVL2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMONTRAITPACKLVL2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

