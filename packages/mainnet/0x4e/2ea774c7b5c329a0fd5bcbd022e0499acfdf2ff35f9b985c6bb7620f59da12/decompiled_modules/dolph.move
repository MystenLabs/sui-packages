module 0x4e2ea774c7b5c329a0fd5bcbd022e0499acfdf2ff35f9b985c6bb7620f59da12::dolph {
    struct DOLPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPH>(arg0, 6, b"DOLPH", b"DOLPHIN VERSE", x"4d616b652057617665732e205269646520746865204d656d6520546964652e0a57656c636f6d6520746f20446f6c7068696e56657273652c2061206d656d6520636f696e206f6e205375692074686174277320666173742c2066756e2c20616e6420666c697070696e6720746865207363726970742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifa53s7lhtwpeenmdivxfmatxk3r5oujteuw4dvja7qt5j2esd2tq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOLPH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

