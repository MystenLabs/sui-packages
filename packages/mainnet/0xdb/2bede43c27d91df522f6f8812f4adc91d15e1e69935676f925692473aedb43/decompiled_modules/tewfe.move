module 0xdb2bede43c27d91df522f6f8812f4adc91d15e1e69935676f925692473aedb43::tewfe {
    struct TEWFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEWFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEWFE>(arg0, 6, b"TEWFE", b"TFWEFFE", b"WFWT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731392072441.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEWFE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEWFE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

