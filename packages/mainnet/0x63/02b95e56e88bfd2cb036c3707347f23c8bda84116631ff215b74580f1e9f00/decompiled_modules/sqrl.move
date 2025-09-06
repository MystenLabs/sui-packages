module 0x6302b95e56e88bfd2cb036c3707347f23c8bda84116631ff215b74580f1e9f00::sqrl {
    struct SQRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQRL>(arg0, 6, b"SQRL", b"SQUIRRELORN", x"49e280996d20612064616d6e20737175697272656c2d756e69636f726e20f09f90bff09fa684207769746820245351524c2e204d79206e7574732061726520646563656e7472616c697a65642c206d79206d656d657320756e73746f707061626c652e20496620796f752077616e74656420736572696f75732066696e616e63652c20676f20637279207769746820476f6c646d616e2e20245351524c2069732070757265206368616f732c2066726565206e7574732c20616e64206d6964646c652066696e67657220746f2057616c6c205374726565742e204a6f696e206f7220737461792062726f6b652c20796f75722063616c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1757160462574.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

