module 0x5b6258f3aabddc07775ccc25b3f9379851298997237bf7ad6f0c8bf83abd11a5::suinda {
    struct SUINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINDA>(arg0, 6, b"SUINDA", b"SUINDAQUIL", b"suinda-suinda!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749841298719.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

