module 0x5bf2180d7001a08896642a0a8b5184df6764f606d563d20443046b2806ecb7d4::piss {
    struct PISS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISS>(arg0, 6, b"PISS", b"PISS SUI", b"PISS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/piss_204efe9bd9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PISS>>(v1);
    }

    // decompiled from Move bytecode v6
}

