module 0xd3c062e623667a6d27124c6de95031efc07a8cc2c67990a8ad388d4f8fcb8b27::bbets {
    struct BBETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBETS>(arg0, 6, b"BBets", b"BonkBetssui", b"BonkBets_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/k_FS_9i_R_I_400x400_3935fa58f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

