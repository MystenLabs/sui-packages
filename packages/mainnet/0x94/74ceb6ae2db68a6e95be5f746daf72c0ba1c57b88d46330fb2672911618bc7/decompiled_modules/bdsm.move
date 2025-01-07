module 0x9474ceb6ae2db68a6e95be5f746daf72c0ba1c57b88d46330fb2672911618bc7::bdsm {
    struct BDSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDSM>(arg0, 6, b"BDSM", b"Bad Doy Save Money", b"BDSM is a guiding light for those who are not afraid to swim against the tide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002799_2803bc4b53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

