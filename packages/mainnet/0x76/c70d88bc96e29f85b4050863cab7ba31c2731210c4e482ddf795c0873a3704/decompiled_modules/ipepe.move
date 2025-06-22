module 0x76c70d88bc96e29f85b4050863cab7ba31c2731210c4e482ddf795c0873a3704::ipepe {
    struct IPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPEPE>(arg0, 6, b"IPEPE", b"Icepepe", x"496e2074686520646565702066726f7374206f662063727970746f2077696e7465722c207768656e20616c6c20686f7065206d656c74656420617761792c20686520656d65726765642e0a4e6f742061732061206865726f2c206e6f7420617320612076696c6c61696e2062757420617320612066726f7a656e207769746e65737320746f206576657279207275672c2064756d702c20616e642062726f6b656e20647265616d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif3th5exg7gl5rzt2wkr23qabnsd7l7xjyyoqoj3gzud52lruafye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IPEPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

