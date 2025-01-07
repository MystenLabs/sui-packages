module 0xd6f9da9512086213e8453faca9dbb5f374b906ba58ab3009b61aebd07ff23cb5::sui2 {
    struct SUI2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI2>(arg0, 6, b"SUI2", b"Sui2", x"53756920322e200a32205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030677_3dde002775.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI2>>(v1);
    }

    // decompiled from Move bytecode v6
}

