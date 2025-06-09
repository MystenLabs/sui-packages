module 0x55aae6859e68a057d32b3baf51d028914f9f662182024e8d00896d79e5c81244::hopx {
    struct HOPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPX>(arg0, 6, b"HOPX", b"Space Bunny", x"537061636542756e6e79202824484f505829206973207468652067616c617879e2809973206d6f7374207261646963616c206d656d65636f696e2c20666f6c6c6f77696e6720746865206c6567656e646172792074616c65206f6620666561726c6573732062756e6e69657320736b6174696e67207468726f7567682074686520636f736d6f73206f6e2061206d697373696f6e20746f207370726561642076696265732c206d656d65732c20616e6420646563656e7472616c697a6564206a6f79206163726f73732074686520626c6f636b636861696e20756e6976657273652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749506691429.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

