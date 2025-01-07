module 0xb777ffe9228e734b72e18f28f2e0c597dc8b1b616e5afdc6388aa3dd0c2c62c::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SC>(arg0, 6, b"SC", b"SCION", b"Sui has become the first Layer-1 project to run SCION (now in Testnet), a stronger alternative to the routing and forwarding protocols in today's Internet, improving Sui's security and resilience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241005132502_e2dae3fae6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SC>>(v1);
    }

    // decompiled from Move bytecode v6
}

