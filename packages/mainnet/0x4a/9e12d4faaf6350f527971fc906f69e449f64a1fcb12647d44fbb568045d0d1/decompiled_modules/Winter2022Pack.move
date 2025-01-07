module 0x4a9e12d4faaf6350f527971fc906f69e449f64a1fcb12647d44fbb568045d0d1::Winter2022Pack {
    struct WINTER2022PACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTER2022PACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTER2022PACK>(arg0, 0, b"PACK", b"Winter 2022 Pack", b"Dress up your Aurahma with Trait Packs, the perfect way to create your very own unique combination!  This pack contains 4 Original traits and 1 Winter 2022 trait. Winter 2022 traits are a limited edition mint that will never be printed again after 2022. There are 15 traits in existence; each are common and have a 6.67% drop rate. They can be alchemized in the Forge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Winter_2022_Pack.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINTER2022PACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTER2022PACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

