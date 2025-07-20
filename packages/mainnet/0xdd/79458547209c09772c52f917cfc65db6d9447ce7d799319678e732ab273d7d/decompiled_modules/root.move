module 0xdd79458547209c09772c52f917cfc65db6d9447ce7d799319678e732ab273d7d::root {
    struct ROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ROOT>(arg0, 6, b"ROOT", b"RootBoy", b"@suilaunchcoin $ROOT + RootBoy https://t.co/DYMeBL205r", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/root-o1930m.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

