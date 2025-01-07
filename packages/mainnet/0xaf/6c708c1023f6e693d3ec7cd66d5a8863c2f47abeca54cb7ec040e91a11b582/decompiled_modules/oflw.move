module 0xaf6c708c1023f6e693d3ec7cd66d5a8863c2f47abeca54cb7ec040e91a11b582::oflw {
    struct OFLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFLW>(arg0, 9, b"OFLW", b"Ocean Flow", x"224f464c57206973206120776176652d7468656d6564206d656d6520636f696e20726964696e6720746865207469646573206f66207468652063727970746f20776f726c642c2064657369676e656420666f722066756e20616e6420636f6d6d756e6974792e204a6f696e2074686520666c6f7720616e642073757266207468652072697365206f6620746865206e65787420626967206d656d6520746f6b656e21220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a683f8fd-3950-4655-9c9f-a5437f3912d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFLW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OFLW>>(v1);
    }

    // decompiled from Move bytecode v6
}

