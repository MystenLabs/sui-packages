module 0xb67d02577ecb9ea306446faedae59a01cfb18d36d73139f24cb2e25726f2e50f::devcat {
    struct DEVCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVCAT>(arg0, 6, b"DEVCAT", b"The Dev Cat", x"6465662072756e28293a0a202020207072696e742822696e697469616c697a696e6720646576636174206572612e2e2e2022292024444556434154", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n_ZZAY_Ik3_400x400_b8f89deda9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

