module 0x3a017cef909d55c0d9b637f49f69452727469b711051c6154569a3799b4ff1a4::jorgie {
    struct JORGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JORGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JORGIE>(arg0, 6, b"JORGIE", b"Jorgie Monkey", x"4d79206e616d65206973204a6f7267696520616e6420492068617665206265656e206b69646e61707065642062792074686520555320676f7665726e6d656e742e0a0a496d206a7573742061206d6f6e6b65792c206c6574206d65206d6f6e656b792061726f756e6420696e2070656163652c20736574206d652066726565", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xabf5ce61c883830e81812ec73de4238b98d226603343b7e83d99c457ffb83a3a_jorgie_jorgie_80a3cf6598.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JORGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JORGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

