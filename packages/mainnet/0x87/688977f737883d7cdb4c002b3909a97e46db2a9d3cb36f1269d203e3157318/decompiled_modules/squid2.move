module 0x87688977f737883d7cdb4c002b3909a97e46db2a9d3cb36f1269d203e3157318::squid2 {
    struct SQUID2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID2>(arg0, 6, b"Squid2", b"Squid game", b"We come back for change your life player", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040467_560d5d9487.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUID2>>(v1);
    }

    // decompiled from Move bytecode v6
}

