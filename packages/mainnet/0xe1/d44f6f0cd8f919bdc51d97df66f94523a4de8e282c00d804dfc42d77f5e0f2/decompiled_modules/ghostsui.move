module 0xe1d44f6f0cd8f919bdc51d97df66f94523a4de8e282c00d804dfc42d77f5e0f2::ghostsui {
    struct GHOSTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOSTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOSTSUI>(arg0, 6, b"GhostSui", b"Ghost of SuiShima", x"5355492053616b61692077696c6c206272696e672070726f7370657269747920746f207468652070656f706c65206f66205355495368696d612e0a49207368616c6c206c65617665206e6f20736f756c20626568696e6420696e207468697320626174746c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ghostof_SUI_1_d21aefac0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOSTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOSTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

