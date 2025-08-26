module 0x1a42af3ddc34c73446b676db90649188ed7a62c9aca1e55f2ac121ece4ec1b20::Cyber_Lion {
    struct CYBER_LION has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBER_LION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBER_LION>(arg0, 9, b"LION", b"Cyber Lion", b"cybernetic lion. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9090/kit/TemporaryCoinAvatar/01K3KMMBBV2S7Z62PQB2642RVH.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYBER_LION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBER_LION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

