module 0xe4f14a8dfeffb752fdf3bb01be92d73207d473a1463a2483321bdd9148387a34::pelosui {
    struct PELOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELOSUI>(arg0, 6, b"PELOSUI", b"NONCE PELOSUI", b"She is the best trader alive. Nonce doesn't jeet. She has government alpha. Learn how to hold like Pelosui. Get in early.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6023752651696621627_121_ce43cb4214.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

