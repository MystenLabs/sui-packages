module 0xf7f97ef4e4830db9418394d8de87b357f672739703a9bba7ad3550326368c0a8::ips {
    struct IPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPS>(arg0, 6, b"IPS", b"IVPS", x"50726f6a65746f2064652049412071756520617475617261206e6120636f6d756e696361c3a7616f20656e747265206173207265646573202c7472616e7a61c3a76f65207365677572612065203130302520616d6f6e696d6173207365677572616ec3a76120746f74616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735421081614.44")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

