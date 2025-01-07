module 0x18c5a7f6715fa0a9dab9000b0ccaacc7a851e1263e710b82f37c227be2edc31a::swarm {
    struct SWARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARM>(arg0, 6, b"SWARM", b"Swarm", x"546865204d656d65204d6f76656d656e74206973204c65616465726c6573732c206c696b65206120537761726d2e0a0a5472756520446563656e7472616c697a6174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017089_6b519798aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

