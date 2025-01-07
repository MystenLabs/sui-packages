module 0xfef0392c788921220a2b2a99ada6260728e45502543ab6f460c7bc5a42fed642::catspump {
    struct CATSPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSPUMP>(arg0, 6, b"CATSPUMP", b"CATS PUMP", b"Only a CAT meme for community SUI Cats meme #CatsPump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catspump_0e9bbf5906_70c4b35e6b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

