module 0xa94e5837add4d3f51a1bd8cfb121ad1a827911ecf79360cf3a71906b786cc874::ddl {
    struct DDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDL>(arg0, 9, b"DDL", b"dodol", b"ghh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93763e32-7759-4897-999d-60674f9d2240.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDL>>(v1);
    }

    // decompiled from Move bytecode v6
}

