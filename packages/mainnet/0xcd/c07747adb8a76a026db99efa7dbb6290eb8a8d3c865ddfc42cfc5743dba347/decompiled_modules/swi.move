module 0xcdc07747adb8a76a026db99efa7dbb6290eb8a8d3c865ddfc42cfc5743dba347::swi {
    struct SWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWI>(arg0, 6, b"SWI", b"SuiWoman Inu", x"426563617573652057686f204e656564732046696e616e6369616c20456d706f7765726d656e74205768656e20596f752043616e204861766520446f67653f0a0a537569576f6d616e20496e752069732061206d656d652070726f6a65637420746861742061696d7320746f206272696e67206c617567687465722c206a6f792c20616e642061206865616c74687920646f7365206f662061627375726469747920746f207468652063727970746f2073706163652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_0ca709d6a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

