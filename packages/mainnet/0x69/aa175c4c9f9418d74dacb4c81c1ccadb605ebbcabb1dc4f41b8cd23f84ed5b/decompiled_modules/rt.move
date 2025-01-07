module 0x69aa175c4c9f9418d74dacb4c81c1ccadb605ebbcabb1dc4f41b8cd23f84ed5b::rt {
    struct RT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RT>(arg0, 6, b"Rt", b"Robotaxi", b"Tesla's robotaxi service is part of Elon Musk's vision for autonomous ride-hailing. The concept involves using Tesla's electric vehicles (EVs) equipped with full self-driving (FSD) capabilities to operate as autonomous taxis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728131427232_a1186e3fda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RT>>(v1);
    }

    // decompiled from Move bytecode v6
}

