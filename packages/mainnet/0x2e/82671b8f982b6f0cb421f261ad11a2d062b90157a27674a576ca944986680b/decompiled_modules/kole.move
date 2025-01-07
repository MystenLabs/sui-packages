module 0x2e82671b8f982b6f0cb421f261ad11a2d062b90157a27674a576ca944986680b::kole {
    struct KOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLE>(arg0, 6, b"KOLE", b"Kolesui", b"Hello, I'm Kole, I'm very lazy and I like to be sleepy. Join and follow me on telegram and twitter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul2_20241213090358_c947a24fc7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

