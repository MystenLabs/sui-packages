module 0xd0d9959b9813efaa2207554fdf5025cd73bad8e37b237606e5424c1fc29f1ee2::suihat {
    struct SUIHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHAT>(arg0, 6, b"SUIHAT", b"SUIHAT TOKEN", x"4d414b452053554920475245415420414741494e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suihat_42081cf03d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

