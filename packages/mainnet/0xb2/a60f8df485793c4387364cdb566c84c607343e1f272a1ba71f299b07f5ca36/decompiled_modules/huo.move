module 0xb2a60f8df485793c4387364cdb566c84c607343e1f272a1ba71f299b07f5ca36::huo {
    struct HUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUO>(arg0, 6, b"HUO", b"H U O", x"5355492056532048554f20200a4974207761732061206a6f6b6520616e6420686164206e6f206d65726974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9c14b4d033094661212cff9b5618578_bd5e5eaf5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUO>>(v1);
    }

    // decompiled from Move bytecode v6
}

