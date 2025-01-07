module 0x8dad1fbdc9a24d95c6c589b688b1895ec10cf1fa18c3d650b4c72eb6db54ce05::chonkr {
    struct CHONKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONKR>(arg0, 6, b"CHONKR", b"Chonkr Cat", x"68657320726561647920746f2045415421200a4865732061206661742c206368756e6b79206361742074686174206c6976657320666f72206869732062726561642e2048617264776f726b696e672c2068756e6772792c20616e64206a7573742061206c6974746c65206c617a792e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004860_1b1b450c62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHONKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

