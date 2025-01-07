module 0x5f6260e66d539670480516ae00a004217079aa02e716e74b80682388999a4b4c::snowm {
    struct SNOWM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWM>(arg0, 6, b"SNOWM", b"Snowflake  Monkey", x"24534e4f574d20746f6b656e2062656e65666974732065766572796f6e652077686f0a73796d70617468697a6573207769746820536e6f77666c616b6573206d6f6e6b6579732e20546869730a66616e74617374696320616e696d616c2068617320776861742069742074616b657320746f20677261620a746865206d61726b6574277320617474656e74696f6e2c20616e64206974277320726561647920746f0a70726f76652069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/httpssuisnowflake_fun_d9801e4401.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWM>>(v1);
    }

    // decompiled from Move bytecode v6
}

