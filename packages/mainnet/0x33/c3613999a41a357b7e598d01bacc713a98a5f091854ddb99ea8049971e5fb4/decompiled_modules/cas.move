module 0x33c3613999a41a357b7e598d01bacc713a98a5f091854ddb99ea8049971e5fb4::cas {
    struct CAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAS>(arg0, 6, b"CAS", b"Canguru AI Agent Sui", b"Canguru AI Agent SUI combines the adventurous spirit of the kangaroo with cutting-edge blockchain technology, making it the perfect choice for those looking to leap into the future of digital finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o4_AC_Emq_H_400x400_63e7deef8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

