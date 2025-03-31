module 0xbe63524f63b8d4ba96948e7971a3d0da95d73ba7d3aad06bc62915ebb5456300::rekt {
    struct REKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REKT>(arg0, 9, b"REKT", b"Don't get REKT!", x"4265656e2052454b5420746f6f206d616e792074696d657320696e207468652063727970746f20776f726c642e2054696d6520746f206368616e676520746861742e2053686172696e67206f6e6c792070726f6a6563747320776f72746820796f75722074696d652e20f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/404d9a42486e794811e8ee4c04c9d48ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REKT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REKT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

