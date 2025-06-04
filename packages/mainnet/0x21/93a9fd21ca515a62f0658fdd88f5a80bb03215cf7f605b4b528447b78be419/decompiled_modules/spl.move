module 0x2193a9fd21ca515a62f0658fdd88f5a80bb03215cf7f605b4b528447b78be419::spl {
    struct SPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL>(arg0, 6, b"Spl", b"Super League", b"Super League Token is more than just a game; it's a community-driven ecosystem where football enthusiasts can connect,compete, and celebrate the sport they love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifz3wuykkraadpydzdgyvjmzlnoyjyy7y5yhvdix2tof33hnbfedy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

