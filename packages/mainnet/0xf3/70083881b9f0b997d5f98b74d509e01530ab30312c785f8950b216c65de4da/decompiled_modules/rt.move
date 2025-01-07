module 0xf370083881b9f0b997d5f98b74d509e01530ab30312c785f8950b216c65de4da::rt {
    struct RT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RT>(arg0, 6, b"RT", b"Robotaxi", b"Tesla's robotaxi service is part of Elon Musk's vision for autonomous ride-hailing. The concept involves using Tesla's electric vehicles (EVs) equipped with full self-driving (FSD) capabilities to operate as autonomous taxis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_67d5518298.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RT>>(v1);
    }

    // decompiled from Move bytecode v6
}

