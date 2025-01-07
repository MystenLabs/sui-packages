module 0x9127e79edad5bdd46cebb0151046e85f5e1fffebc34aa3b05cf55070848c08f0::nkendb {
    struct NKENDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKENDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKENDB>(arg0, 9, b"NKENDB", b"hekdn", b"jsiwj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a943b01-31f7-4ff8-b4ba-32e98ae9425d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKENDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKENDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

