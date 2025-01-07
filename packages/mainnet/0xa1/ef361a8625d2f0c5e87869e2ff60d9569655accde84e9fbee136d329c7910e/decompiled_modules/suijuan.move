module 0xa1ef361a8625d2f0c5e87869e2ff60d9569655accde84e9fbee136d329c7910e::suijuan {
    struct SUIJUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJUAN>(arg0, 6, b"SUIJUAN", b"Suijuan", b"Meet Juan, the Mexican frog bringing fiesta vibes to the world of crypto. This lively memecoin blends fun and culture, hopping to success with every leap!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240914125728_3289246802.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

