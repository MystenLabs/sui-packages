module 0xd3dfe956c101d7af285081959bcad0d468fb8e1003bc5865b64b136b09918e0c::rinoco {
    struct RINOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RINOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RINOCO>(arg0, 9, b"RINOCO", b"RINOCO", x"57656c636f6d6520746f207468652052696e6f636f20576f726c643a20576865726520796f7572206661766f72697465206375746520706574732073707265616420676f6f6420766962657320f09f90be20546865204f66666963616c20546f6b656e20666f722052696e6f636f20576f726c64202d2068747470733a2f2f6c696e6b74722e65652f72696e6f636f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RINOCO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RINOCO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RINOCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

