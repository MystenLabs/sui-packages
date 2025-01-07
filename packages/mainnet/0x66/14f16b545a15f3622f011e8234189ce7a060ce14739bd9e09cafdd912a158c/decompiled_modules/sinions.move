module 0x6614f16b545a15f3622f011e8234189ce7a060ce14739bd9e09cafdd912a158c::sinions {
    struct SINIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINIONS>(arg0, 6, b"SINIONS", b"SINIONS SUI", x"42696e696f6e73206f6e204261736520696e766164696e672063727970746f20746f2061206e6577206c6576656c206f66206d61646e65737320796f75277665206e65766572207365656e206265666f72652e2042616e616e616161616161612121200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ui_Hc9v4h_400x400_f7bac97475.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINIONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINIONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

