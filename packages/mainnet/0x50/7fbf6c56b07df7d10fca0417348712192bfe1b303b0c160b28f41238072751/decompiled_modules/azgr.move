module 0x507fbf6c56b07df7d10fca0417348712192bfe1b303b0c160b28f41238072751::azgr {
    struct AZGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZGR>(arg0, 9, b"AZGR", b"Az", b"Abc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc5d1ef7-3e9f-4b27-a6ec-fc3e55b230ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AZGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

