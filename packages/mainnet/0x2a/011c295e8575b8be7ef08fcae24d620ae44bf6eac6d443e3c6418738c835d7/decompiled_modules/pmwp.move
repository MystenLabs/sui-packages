module 0x2a011c295e8575b8be7ef08fcae24d620ae44bf6eac6d443e3c6418738c835d7::pmwp {
    struct PMWP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMWP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMWP>(arg0, 6, b"PMWP", b"pepe in a memes world Price", b"BE UPDATED ALWAYS TO SOME ANNOUNCEMENTS!1!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PEW_2_f1b0577ca8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMWP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMWP>>(v1);
    }

    // decompiled from Move bytecode v6
}

