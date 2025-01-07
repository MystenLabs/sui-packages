module 0xabc590565b7098557448ae7b7cfdc15a14603fbcd700a5bedafa407141fd6120::StarterPack2 {
    struct STARTERPACK2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARTERPACK2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARTERPACK2>(arg0, 0, b"PACK", b"Starter Pack 2", b"Dress up your Aurahma with Trait Packs, the perfect way to create your very own unique combination! With randomly generated traits of varying rarities, you can craft, trade and merge your way to creating a look that stands out!  This pack contains 3 random Traits. Rarity distribution: 97% Common, 2.5% Uncommon, 0.5% Rare.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Common_Trait_Pack_LVL_1.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARTERPACK2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARTERPACK2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

