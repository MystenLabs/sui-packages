module 0x3d369165d281a54d02e943eedb8286372b1201dd906ec436311ac9a110248546::atlan {
    struct ATLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATLAN>(arg0, 6, b"ATLAN", b"ATLANTIS", b"ATLAN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731006504956.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATLAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATLAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

