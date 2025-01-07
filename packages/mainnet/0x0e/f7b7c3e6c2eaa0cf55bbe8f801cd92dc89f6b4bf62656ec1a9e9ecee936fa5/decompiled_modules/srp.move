module 0xef7b7c3e6c2eaa0cf55bbe8f801cd92dc89f6b4bf62656ec1a9e9ecee936fa5::srp {
    struct SRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRP>(arg0, 6, b"SRP", b"Seraphim Angel", x"54686520536572617068696d2061726520616c6c20657965732020746865792063616e2070657263656976652074727565206265617574792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1003_6ec47d0d5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

