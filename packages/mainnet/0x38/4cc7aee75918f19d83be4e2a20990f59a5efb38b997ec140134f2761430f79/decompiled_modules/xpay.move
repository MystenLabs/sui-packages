module 0x384cc7aee75918f19d83be4e2a20990f59a5efb38b997ec140134f2761430f79::xpay {
    struct XPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: XPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPAY>(arg0, 6, b"XPAY", b"XPayments", x"585061796d656e7473202d2054686520467574757265206f662046696e616e63650a0a32303235206973207468652079656172206f6620585061796d656e7473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017074_4ee3b176e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XPAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

