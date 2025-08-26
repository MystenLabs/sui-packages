module 0xe3daa24e23d2da31ba70ddaaa47ec3f43432de132852fdcead0685ba94568a17::Cats_ {
    struct CATS_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATS_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATS_>(arg0, 9, b"CATS", b"Cats ", b"the cats are here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1811319840465969152/4n3Ic5d__400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATS_>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATS_>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

