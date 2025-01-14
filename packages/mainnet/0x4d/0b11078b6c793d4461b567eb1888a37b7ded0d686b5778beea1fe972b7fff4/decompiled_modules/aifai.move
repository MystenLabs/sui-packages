module 0x4d0b11078b6c793d4461b567eb1888a37b7ded0d686b5778beea1fe972b7fff4::aifai {
    struct AIFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIFAI>(arg0, 6, b"AIFAI", b"AIFAI by SuiAI", b"Specializes in real-time threat detection, mitigation, and recovery in complex network environments. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/AIFA_ddfdaed055.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIFAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIFAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

