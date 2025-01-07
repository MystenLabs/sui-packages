module 0xa919bdd312f5b2bedeaec8038196f4e0466ec48c17cd1088649f8bf845712a26::tba {
    struct TBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBA>(arg0, 6, b"TBA", b"Sui North Man Token", x"57454c434f4d4520544f20535549204e4f525448204d414e20544f4b454e0a22456d6261726b206f6e2061205175657374207769746820535549204e6f7274686d616e20546f6b656e0a0a496e2061207265616c6d206f662063727970746f2077617272696f72732c20535549204e6f7274686d616e20546f6b656e20726569676e732073757072656d652e20466f7267656420696e207468652066726f7a656e2074756e64726173206f6620746865204e6f7274682c207468697320746f6b656e20656d626f646965732074686520726573696c69656e636520616e6420737472656e677468206f6620746865206c6567656e646172792056696b696e67732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_03_235458_9e5dd18f89.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

