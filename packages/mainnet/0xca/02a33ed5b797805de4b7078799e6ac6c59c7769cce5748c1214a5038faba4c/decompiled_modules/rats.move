module 0xca02a33ed5b797805de4b7078799e6ac6c59c7769cce5748c1214a5038faba4c::rats {
    struct RATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATS>(arg0, 6, b"Rats", b"Rats on Sui", b"https://t.me/ratsonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_12_51_31_f5698194b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

