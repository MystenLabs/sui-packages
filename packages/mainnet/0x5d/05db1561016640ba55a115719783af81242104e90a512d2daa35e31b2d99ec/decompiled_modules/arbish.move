module 0x5d05db1561016640ba55a115719783af81242104e90a512d2daa35e31b2d99ec::arbish {
    struct ARBISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARBISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARBISH>(arg0, 6, b"ARBISH", b"ARBISH DOG", x"4655434b20484f5046554e202c207765277665206465636964656420746f206c61756e6368206f6e20747572626f732e66696e616e63650a415242495348206f6666657273206120636f6d70656c6c696e672070726f64756374207468617420617474726163747320757365727320616e6420616464732076616c756520746f20746865205355492065636f73797374656d0a68747470733a2f2f7777772e6172626973682e696f2f0a68747470733a2f2f742e6d652f6172626973685f706f7274616c0a68747470733a2f2f782e636f6d2f617262697368646f67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731059995946.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARBISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARBISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

