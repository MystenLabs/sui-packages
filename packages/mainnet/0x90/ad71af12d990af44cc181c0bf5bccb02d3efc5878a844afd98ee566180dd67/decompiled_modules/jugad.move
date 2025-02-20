module 0x90ad71af12d990af44cc181c0bf5bccb02d3efc5878a844afd98ee566180dd67::jugad {
    struct JUGAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUGAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUGAD>(arg0, 6, b"JUGAD", b"JUGAD OG Trenches", x"4a5547414420434f494e3a2054686520576f726c64e28099732046697273742050726f626c656d2d536f6c76696e672c204c75636b2d4d616e6966657374696e67204d656d6520546f6b656e20284966206c69666520676976657320796f75206c656d6f6e732c204a5547414420436f696e20676976657320796f7520612066756c6c79206c6f61646564206c656d6f6e616465207374616e64207769746820667265652057692d46692e29200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740041579995.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUGAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUGAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

