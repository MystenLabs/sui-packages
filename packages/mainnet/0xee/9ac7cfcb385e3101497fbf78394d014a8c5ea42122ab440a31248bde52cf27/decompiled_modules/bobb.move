module 0xee9ac7cfcb385e3101497fbf78394d014a8c5ea42122ab440a31248bde52cf27::bobb {
    struct BOBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBB>(arg0, 6, b"BOBB", b"BOBB on sui", x"69747320424f42422120424f4242204f4e20535549204576657279626f6479206c6f76657320424f42422e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_2024_10_14_T211600_131_0e06cc52c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

