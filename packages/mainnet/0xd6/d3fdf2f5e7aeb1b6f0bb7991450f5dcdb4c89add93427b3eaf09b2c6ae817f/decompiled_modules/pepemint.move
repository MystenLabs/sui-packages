module 0xd6d3fdf2f5e7aeb1b6f0bb7991450f5dcdb4c89add93427b3eaf09b2c6ae817f::pepemint {
    struct PEPEMINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEMINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEMINT>(arg0, 6, b"PEPEMINT", b"PEPEMINT SUI", x"504550454d494e54206973206865726520746f207368616b6520757020746865206d656d6520636f696e207363656e650a576562736974653a2068747470733a2f2f706570656d696e742e706167652f2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200a583a2068747470733a2f2f782e636f6d2f706570656d696e74736f6c202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200a54473a2068747470733a2f2f742e6d652f2b576b494c6739747032726b315a544d300a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_19_13_12_09_3aee0fd897.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEMINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEMINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

