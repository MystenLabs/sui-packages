module 0x4964aaaa2b83d0a577a2889fdd1b00b2a84c58df910ebbd5112248b00b3944b9::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAI>(arg0, 6, b"SAI", b"STONEFISH AI", x"5468652073746f6e656669736820697320726567617264656420617320746865206d6f73742076656e6f6d6f7573206669736820696e2074686520776f726c642c20616e64206974277320726561647920746f2074616b65206f7665722074686520537569204f6365616e2120536f6369616c7320636f6d696e6720736f6f6ee280946c65742773206d616b6520776176657321204c464721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733622803832.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

