module 0x9daa447fc497af2e1051dd42fc23240a5fd8e740340c6d5961e569e20e0ca515::moo_dengg {
    struct MOO_DENGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO_DENGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO_DENGG>(arg0, 6, b"MOO DENGG", b"MOODENG", b"MOO DENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/Y1zL3uAN3TpeadMs5")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<MOO_DENGG>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<MOO_DENGG>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

