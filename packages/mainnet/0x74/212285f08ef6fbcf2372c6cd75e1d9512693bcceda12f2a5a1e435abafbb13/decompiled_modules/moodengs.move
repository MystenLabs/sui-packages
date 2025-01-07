module 0x74212285f08ef6fbcf2372c6cd75e1d9512693bcceda12f2a5a1e435abafbb13::moodengs {
    struct MOODENGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENGS>(arg0, 6, b"MOODENGS", b"MOODENG", b"An unofficial fan page / memecoin of Moo Deng on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727147865211_2_06216e1c1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

