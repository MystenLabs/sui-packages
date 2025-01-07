module 0x9bf44a1100a69b35b9d1b4c0c32b2a87711e3711d244e76e70ef0eadf93889b4::dalek {
    struct DALEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DALEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DALEK>(arg0, 6, b"DALEK", b"Dalek", b"A Blue Chrono Dalek was wondering in space and time, when he found the SUI network, he decided it was his enemy so he wants to take over SUI and crown himself, so he proves Daleks are the superior race in the universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_2_15a5ce4f22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DALEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DALEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

