module 0x9a8cc48b4775f302005db8ac78b462fb26cbd958f787c219da66b1a182e32acd::purplish {
    struct PURPLISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURPLISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURPLISH>(arg0, 6, b"PURPLISH", b"PURPLISH Sui", x"505552504c495348200a3237746820617474656d70742e200a3530252073656c6c202d2035302520627579207374726174656779", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020182_e2c2f72c3f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURPLISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURPLISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

