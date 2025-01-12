module 0x75636c032e9f60eaff6d0c386d4d55cd7ae0eb7a184ebb2c76d626eee3fa2800::pepu {
    struct PEPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPU>(arg0, 9, b"PEPU", b"PEPE FOR SUI", b"PEPE is too cool for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/39b1a0d39d093a112dac0537765f72ebblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

