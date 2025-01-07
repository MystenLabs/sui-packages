module 0x5db45850523f4c6d0001c8207fa54b8466836a9f13604acfc2ddc1cccb99d592::ping {
    struct PING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PING>(arg0, 6, b"PING", b"PING SUI", b"A cute little dog on the sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ge_T_Xma_RG_400x400_df4b472f76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PING>>(v1);
    }

    // decompiled from Move bytecode v6
}

