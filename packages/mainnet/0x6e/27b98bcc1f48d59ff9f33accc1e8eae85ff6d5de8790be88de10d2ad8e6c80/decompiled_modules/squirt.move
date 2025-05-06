module 0x6e27b98bcc1f48d59ff9f33accc1e8eae85ff6d5de8790be88de10d2ad8e6c80::squirt {
    struct SQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRT>(arg0, 6, b"SQUIRT", b"SquirtCoin", x"41667465722069742067657473206d6f6973742c20697420737175697274732e0a0a546865207765747465737420636f696e206f6e20537569206865726520746f206d616b652074686520776174657220636861696e207371756972742077697468206761696e732e0a0a4e6f2054472c206e6f20636162616c2c2073717569727420667265656c7920616c6c206f7665722074686520626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_70_78fbe40d28.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

