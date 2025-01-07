module 0xfcd44b8a050b008f496d349d0675464aff5a8bff9d298183fc18a48dad0b011c::suite {
    struct SUITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITE>(arg0, 6, b"SUITE", b"Suite Bots", b"Elevate your SUI experience to highest level with our advanced bots.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_f6b04690e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

