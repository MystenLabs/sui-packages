module 0x2ee4135dea10631a046933e25d3d8e7df365cf0a147425115a038a20e6f685be::pewpew {
    struct PEWPEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEWPEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEWPEW>(arg0, 6, b"PEWPEW", b"PEWPEW on SUI", x"7065772070657720686173206265636f6d652073796e6f6e796d6f7573207769746820746865207665726220746f206f776e2c2061206c656574737065616b207465726d206f6674656e207573656420746f20696e646963617465206f6e652773206162736f6c75746520646f6d696e616e6365206f76657220616e6f7468657220706c617965722e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tda_W4b5_400x400_9de8b34aa9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEWPEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEWPEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

