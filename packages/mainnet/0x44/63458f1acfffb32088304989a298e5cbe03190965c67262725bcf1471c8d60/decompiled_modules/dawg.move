module 0x4463458f1acfffb32088304989a298e5cbe03190965c67262725bcf1471c8d60::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 6, b"Dawg", b"Based Dawg", b"Based dawg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000599031_19647cc33a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

