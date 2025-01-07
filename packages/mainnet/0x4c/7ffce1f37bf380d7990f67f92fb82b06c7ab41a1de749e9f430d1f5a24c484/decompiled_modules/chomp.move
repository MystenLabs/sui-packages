module 0x4c7ffce1f37bf380d7990f67f92fb82b06c7ab41a1de749e9f430d1f5a24c484::chomp {
    struct CHOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMP>(arg0, 6, b"CHOMP", b"CHOMP COIN", b"Sui's s Fiercest Lil Fuzzball", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ktz_E_Jz_Ki_400x400_1e602f152b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

