module 0x727a03fcbba14984c09f110ea1e3c222ae5fbd8dbaec3368a387b8887f59c8f3::brute {
    struct BRUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUTE>(arg0, 6, b"BRUTE", b"Brute", x"2442525554452c2054686520546974616e206f662074686520536f6c616e6120426c6f636b636861696e2069732041626f757420746f2041727269766521200a0a5468652074696d652068617320636f6d6520746f207368616b6520757020746865206d61726b657420616e64207365697a6520706f776572206f6e20536f6c616e612077697468202442525554452120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725636564424_130c11a0682f2f32e56e3f9a2d206a36_a1b5b29771.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

