module 0x57a835fbcdce051f075e03395e43b8c23744ab2f40cd4ff3d7b941e8c0efa43b::peshark {
    struct PESHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESHARK>(arg0, 6, b"PESHARK", b"Pepe Shark", b"PESHARK is a unique deflationary token built on the SUI Chain. What sets PEPE SHARK apart is its strong and dedicated community, which continues to drive its development and resilience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068216_d786aee666.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

