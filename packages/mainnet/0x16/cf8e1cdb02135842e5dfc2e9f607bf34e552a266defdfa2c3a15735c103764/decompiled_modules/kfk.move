module 0x16cf8e1cdb02135842e5dfc2e9f607bf34e552a266defdfa2c3a15735c103764::kfk {
    struct KFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFK>(arg0, 6, b"KFK", b"Kung Fu Kangaroo", b"Kung Fu Kangaroo: The memecoin kicking it on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yy9k_XE_9_J_400x400_be4c8c5df5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

