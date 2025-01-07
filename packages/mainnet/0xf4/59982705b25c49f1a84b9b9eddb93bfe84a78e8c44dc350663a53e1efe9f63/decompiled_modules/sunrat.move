module 0xf459982705b25c49f1a84b9b9eddb93bfe84a78e8c44dc350663a53e1efe9f63::sunrat {
    struct SUNRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNRAT>(arg0, 6, b"SUNRAT", b"Sunrat on Sui", x"57686f206973202453554e524154203f0a0a536f616b696e672075702074686520776973646f6d206f66206d656d65636f696e732c206f6e652072617920617420612074696d6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o08eb_BMB_400x400_c0863a7e86.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

