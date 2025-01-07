module 0xcbd1262c3507be5cc5d9de1d96ee9f3a05a1090ff0041ab56f9bb0364a3f7b5c::blap {
    struct BLAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAP>(arg0, 6, b"BLAP", b"Blap Relaunch", b"BLAP is a hybrid character formed from the combination of the four members of the Boys Club: Brett, Pepe, Andy, and Landwolf. Each member contributes their unique strengths and traits, creating BLAP as an unpredictable and energetic entity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241127_233400_1_f9292a47cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

