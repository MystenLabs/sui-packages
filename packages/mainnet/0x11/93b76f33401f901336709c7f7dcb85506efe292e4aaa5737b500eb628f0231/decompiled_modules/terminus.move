module 0x1193b76f33401f901336709c7f7dcb85506efe292e4aaa5737b500eb628f0231::terminus {
    struct TERMINUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINUS>(arg0, 6, b"TERMINUS", b"Terminus", x"576861742077696c6c20626520746865206e616d65206f66207468652066697273742063697479206f6e204d6172733f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TERMINUS_TGC_2zb_N9e_N_Ba_V_Ui_Zgs_22e5ba96d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERMINUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

