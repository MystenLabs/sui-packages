module 0xb0db655ce23f98732f3a27fa78eb6383a711688673aa357f02fe7078e24118dd::sui888 {
    struct SUI888 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI888, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI888>(arg0, 6, b"SUI888", b"Sui888", b" 888 isnt a product; its a spiritual movement. We dont aim to be usefulwe give meaning to belief.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250501_230639_a3a73d6549.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI888>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI888>>(v1);
    }

    // decompiled from Move bytecode v6
}

