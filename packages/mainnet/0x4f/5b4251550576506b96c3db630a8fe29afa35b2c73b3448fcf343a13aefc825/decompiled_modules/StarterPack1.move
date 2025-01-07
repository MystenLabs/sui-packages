module 0x4f5b4251550576506b96c3db630a8fe29afa35b2c73b3448fcf343a13aefc825::StarterPack1 {
    struct STARTERPACK1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARTERPACK1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARTERPACK1>(arg0, 0, b"PACK", b"Starter Pack 1", b"Dress up your Aurahma with Trait Packs, the perfect way to create your very own unique combination! With randomly generated traits of varying rarities, you can craft, trade and merge your way to creating a look that stands out!   This pack contains 3 random Traits. Rarity distribution: 97% Common, 2.5% Uncommon, 0.5% Rare.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Common_Trait_Pack_LVL_1.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARTERPACK1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARTERPACK1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

