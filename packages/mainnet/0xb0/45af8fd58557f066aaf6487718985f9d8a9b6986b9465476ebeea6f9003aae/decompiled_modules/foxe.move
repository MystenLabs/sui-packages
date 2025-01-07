module 0xb045af8fd58557f066aaf6487718985f9d8a9b6986b9465476ebeea6f9003aae::foxe {
    struct FOXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXE>(arg0, 6, b"FOXE", b"FoxeSui", x"466f7865206469646e74207175697465206d616b65207468652063757420666f722074686520426f797320436c75622e204e6f77206865207370656e647320686973206461797320656e6a6f79696e67207468652066696e6572207468696e6773206c696b65206d656d65636f696e732c2064727567732c20616c636f686f6c20616e6420686f6f6b6572732e0a0a4b696e67206f662074686520736561", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241211_170342_0621bbfc3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXE>>(v1);
    }

    // decompiled from Move bytecode v6
}

