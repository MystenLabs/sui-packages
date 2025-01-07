module 0xd477ed60930250ec2ee6875a7a40d5ea893f9a6b67573a58999207e7f473d020::scb {
    struct SCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCB>(arg0, 6, b"SCB", b"Sacabam", x"5361636162616d206973204f47206d656d6520234275696c644f6e5375692c2024534342206973206e6174697665206d656d65636f696e206f6e205375696e6574776f726b2e546869732076696577206973206162736f6c7574656c79207374756e6e696e67206265796f6e6420776f72647321200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726285918900_76bc5bc4d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

