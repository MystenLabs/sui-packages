module 0x4c5f9d478835482059357843928686549b8b0c5f6fa0856bf4ae66a9ee499359::suipid {
    struct SUIPID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPID>(arg0, 6, b"SUIPID", b"StUIPID", b"dlfjniqnenfqwklmdkflnkleqflw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_41_56fe2c41c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPID>>(v1);
    }

    // decompiled from Move bytecode v6
}

