module 0x644faf86935b57ecb6389fd1a893381f8278b4c48d92176b4cfa382c99dda036::kyuuja {
    struct KYUUJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYUUJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYUUJA>(arg0, 6, b"KYUUJA", b"CATGIRL COIN", b"imagine if you could breed ai systems together and create new ones that arent just copy the original. this is what i want to do with my own. Hosted, self-improving ai ecosystems that can breed and evolve are the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kyuuja400px_505828a2ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYUUJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KYUUJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

