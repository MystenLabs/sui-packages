module 0x487056d529f776e1f270308cfecde3a12794759878ee164613f40e1fbfa9f35c::stronk {
    struct STRONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRONK>(arg0, 6, b"Stronk", b"Sui Stronk", b"Flexing on the Sui chain! Built like a tank, Sui Stronk is here to pump up the whole ecosystem. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_9d62c7c241.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

