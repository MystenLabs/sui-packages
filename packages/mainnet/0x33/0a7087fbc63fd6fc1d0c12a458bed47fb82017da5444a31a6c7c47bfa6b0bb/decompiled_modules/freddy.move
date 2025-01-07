module 0x330a7087fbc63fd6fc1d0c12a458bed47fb82017da5444a31a6c7c47bfa6b0bb::freddy {
    struct FREDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREDDY>(arg0, 6, b"Freddy", b"Freddy Sui Bear", b"UR UR UR UR UR UR UR UR UR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fsml_J_Yo_K_400x4001_5193b9cc6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

