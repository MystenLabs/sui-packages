module 0xff53cb02d78bee5ec98a2b37a95fcac4adee8f70e81fa82083b21b653589df8e::emmy {
    struct EMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMMY>(arg0, 6, b"EMMY", b"Emmy", b"The three colored mouse of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/emma_fdccade056.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

