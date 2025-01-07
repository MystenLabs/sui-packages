module 0x669575a681012daad02441277a153dd3ccd9d9616598d1f5faa7e1bd2d03c8b::pumpapu {
    struct PUMPAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPAPU>(arg0, 6, b"PUMPAPU", b"Pumped Apu", b"Apu on Suiroids", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/apu_7d401d6094.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPAPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPAPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

