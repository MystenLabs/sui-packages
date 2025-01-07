module 0x9dab493c7390db85b582522f4eabdd7a8f178509e0bbedf8f7f09c252cde4f66::dragbrett {
    struct DRAGBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGBRETT>(arg0, 6, b"DRAGBRETT", b"DRAGBRETT SUI", b"Once a great dragon soaring the sky now comes to SUI to dominate the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_22e46e51bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

