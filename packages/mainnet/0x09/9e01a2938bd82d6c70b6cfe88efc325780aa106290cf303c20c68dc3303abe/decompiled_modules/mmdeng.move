module 0x99e01a2938bd82d6c70b6cfe88efc325780aa106290cf303c20c68dc3303abe::mmdeng {
    struct MMDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMDENG>(arg0, 6, b"MMDENG", b"Mcdonald'MooDENG", b"McDonald's Deng arrives in the Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z8t_Z_Yg7e_400x400_e138a0c69c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

