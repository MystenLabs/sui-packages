module 0x6c8eeeb426b3c6df5cb443da43eb1fea4d5e4a705a562e10a79d2339ee4a8e1c::usadev {
    struct USADEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: USADEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USADEV>(arg0, 6, b"USADEV", b"%100 USA", x"5468697320746f6b656e206261736564206f6e2061206d656d65200a446f6e7420666f72676574206f757220646576656c6f706572206973203130302520555341", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieauqzm4x7nccqilx3bgzjvzslbolnbsqqxds2jjlgrand2rvlzrq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USADEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USADEV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

