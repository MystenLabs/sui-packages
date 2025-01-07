module 0xfc75cbd73e1b0e2430ebb0117071b0dcc04b4f79b7794b326a273d567a8c2934::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVAN>(arg0, 6, b"EVAN", b"Evan The Fish", x"57686f20776f756c6420686176652074686f756768742074686174206f6e65206f662074686520666f756e64657273206f66205375692069732061637475616c6c79206120666973683f2120200a200a4d656574204576616e204368656e6720746865206f726967696e616c2066697368206f66205375692e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6075885278268079795_x_59a29321e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

