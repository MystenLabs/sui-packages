module 0x81439f670d19c276eea21aed8218d2ba66ab8f6dc02f7790d732a40e9adf5c8d::sue {
    struct SUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUE>(arg0, 6, b"SUE", b"SUMAE", b"We will fly to the moon together through decentralized power. We will walk this path with you may the force be with us. Join us support SUMAE | SUI NETWORK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sumae_4a466b6e3c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

