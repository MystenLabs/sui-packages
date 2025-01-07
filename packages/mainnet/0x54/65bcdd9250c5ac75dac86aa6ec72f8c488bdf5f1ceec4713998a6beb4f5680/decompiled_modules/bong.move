module 0x5465bcdd9250c5ac75dac86aa6ec72f8c488bdf5f1ceec4713998a6beb4f5680::bong {
    struct BONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONG>(arg0, 6, b"BONG", b"SUI BONG", x"54686520626573742063616e6e616269732073656172636820656e67696e65206f6e2074686520696e7465726e65742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_55_2b78319066.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

