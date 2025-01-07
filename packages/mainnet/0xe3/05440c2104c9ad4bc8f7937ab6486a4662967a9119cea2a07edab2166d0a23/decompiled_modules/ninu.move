module 0xe305440c2104c9ad4bc8f7937ab6486a4662967a9119cea2a07edab2166d0a23::ninu {
    struct NINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINU>(arg0, 6, b"NINU", b"Ninu", b"That the ninu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x8993129d72e733985f7f1a00396cbd055bad6f817fee36576ce483c8bbb8b87b_sudeng_sudeng_0efcaa03e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

