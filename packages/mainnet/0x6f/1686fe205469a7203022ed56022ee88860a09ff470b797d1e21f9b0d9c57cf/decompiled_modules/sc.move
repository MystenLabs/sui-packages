module 0x6f1686fe205469a7203022ed56022ee88860a09ff470b797d1e21f9b0d9c57cf::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SC>(arg0, 6, b"SC", b"SCION", b"Sui has become the first Layer-1 project to run SCION (now in Testnet), a stronger alternative to the routing and forwarding protocols in today's Internet, improving Sui's security and resilience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241005132502_e4588f317c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SC>>(v1);
    }

    // decompiled from Move bytecode v6
}

