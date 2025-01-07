module 0xb17a94bec35807feeea57106f052f5b26637adc910e191597ba530a64b02595c::lud {
    struct LUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUD>(arg0, 9, b"LUD", b"LUD", b"the future of banking ai automated loans services and eventually goods a new way to bank follow u son cybersociaists on instagram :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lh3.googleusercontent.com/gg/AJxt1KPndpHmaR8s6MTKOXc1fCC7vWKmCIwUXO-XEpkCPBP1_-t56qtqJwBx-8eXf9cHVVnMEP6h6bF4fhLVn-VrUWC5ug5W2gkhj-cbZfUiqpOVDKApuILQ0ZcMQGd9x9nKWa87B5xZImxyjXxR6lqPH8bcR12EhWpXrOXjcH6PCxBznY7600Eo")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUD>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

