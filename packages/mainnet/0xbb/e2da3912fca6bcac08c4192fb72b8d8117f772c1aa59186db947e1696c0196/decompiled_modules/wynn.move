module 0xbbe2da3912fca6bcac08c4192fb72b8d8117f772c1aa59186db947e1696c0196::wynn {
    struct WYNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYNN>(arg0, 6, b"WYNN", b"Anita Max Wynn", b"Anita Max Wynn on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_1_3e42d91b56.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WYNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

