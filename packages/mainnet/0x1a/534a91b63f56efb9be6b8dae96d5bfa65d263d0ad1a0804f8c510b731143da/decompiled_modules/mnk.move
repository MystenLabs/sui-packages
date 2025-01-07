module 0x1a534a91b63f56efb9be6b8dae96d5bfa65d263d0ad1a0804f8c510b731143da::mnk {
    struct MNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNK>(arg0, 6, b"MNK", b"MONKEY", b"NBA BASKET MONKEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731362092705.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

