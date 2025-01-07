module 0x6192395aeae84f8f62785e32650c255ffc3cfc9d3a2ce9c168aeea4fd45bc5d0::elonm {
    struct ELONM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONM>(arg0, 6, b"ELONM", b"Elon Matrix", b"Our mission? To awaken the masses, to red-pill humanity one mind at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profmp_1667013204.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONM>>(v1);
    }

    // decompiled from Move bytecode v6
}

