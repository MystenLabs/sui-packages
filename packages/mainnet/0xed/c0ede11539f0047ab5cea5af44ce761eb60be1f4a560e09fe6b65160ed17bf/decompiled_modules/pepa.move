module 0xedc0ede11539f0047ab5cea5af44ce761eb60be1f4a560e09fe6b65160ed17bf::pepa {
    struct PEPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPA>(arg0, 6, b"PEPA", b"Hot Pepper", b"HOTTEST LAUNCH ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihkxwpp3qejuzie7aozgcpq2hprppdtumg4kuee7midrclo6fls4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

