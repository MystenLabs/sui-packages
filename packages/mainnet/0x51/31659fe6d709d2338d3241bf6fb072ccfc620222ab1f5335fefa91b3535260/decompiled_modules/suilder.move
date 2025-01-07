module 0x5131659fe6d709d2338d3241bf6fb072ccfc620222ab1f5335fefa91b3535260::suilder {
    struct SUILDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILDER>(arg0, 6, b"SUILDER", b"Sui Soldier of War", b"Marching through the Sui Network, $SUILDER is a battle hardened warrior. Trained, disciplined, and ready for anythingthis soldier means business.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_c3e33bffc6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

