module 0x2c38eeeded93635865b202efd4c089d75c32cda8682fcc697242ff48f86403f7::skurtl {
    struct SKURTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKURTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKURTL>(arg0, 6, b"SKURTL", b"Skurtl", x"41206375746520616e642062616461737320747572746c6520736872656464696e672069747320776179207468726f75676820535549200a0a68747470733a2f2f6c696e6b74722e65652f736b7572746c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049415_37bb3c667a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKURTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKURTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

