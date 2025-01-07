module 0x95c0f779c32e475ae5cb84828119464fdecf594aa1ee1bdfbc8dbcf116fa5fb3::lqr {
    struct LQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LQR>(arg0, 9, b"LQR", b"liquor", x"5265666c656374696e6720746865207269636820686572697461676520616e64206372616674736d616e73686970206f6620616c636f686f6c6963206265766572616765730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62d03289-d5e7-4394-abad-8541be6e45c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LQR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LQR>>(v1);
    }

    // decompiled from Move bytecode v6
}

