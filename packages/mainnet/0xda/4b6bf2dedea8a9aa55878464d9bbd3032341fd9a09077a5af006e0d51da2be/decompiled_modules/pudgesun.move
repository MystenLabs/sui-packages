module 0xda4b6bf2dedea8a9aa55878464d9bbd3032341fd9a09077a5af006e0d51da2be::pudgesun {
    struct PUDGESUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDGESUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDGESUN>(arg0, 6, b"PUDGESUN", b"PudgeSun", x"436f6d6d756e6974792c205574696c6974792c20436861726974792e2053756e2068617320697420616c6c2e204f6e2061206d697373696f6e20746f206265636f6d652074686520776f726c642773206d6f7374206b6e6f776e20616e6420757365642063727970746f63757272656e63792e20476574206f76657220686572652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pudge_Sun_T_Roa84_C_Cscn_LZ_02_YQM_4890e12f32.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDGESUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDGESUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

