module 0x422ec04509e44e760f426d09ba91ade8a7dec434c0b3569ad5ebf5dd6934924c::usdd {
    struct USDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDD>(arg0, 9, b"USDD", b"USDD", x"5553444420697320616e206f7665722d636f6c6c61746572616c697a656420646563656e7472616c697a656420737461626c65636f696e2074686174206973206973737565642062792054524f4e2044414f20526573657276652c2077686f20697320616c736f2074686520637573746f6469616e2e2055534444206973206d696e746564206279207468652077686974656c697374656420696e737469747574696f6e73206f66207468652054524f4e2044414f20e280a6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/Ctl4ORqrrQsCAP5tejITnaUPS0LkX2WcAdza_oxgs9A")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDD>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDD>>(v2, @0xa1bae2fc592d51773d6e74c3f15142c2db8ff644d2e34ac6eb329dd1b70f7ecc);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

