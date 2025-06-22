module 0x2a04ae7c7f15a3b67fa718b91cbd255247c40c7c2cbd84481c8f5a977db62f99::joe {
    struct JOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOE>(arg0, 6, b"JOE", b"Joe The Janitor", b"Cleaning the space one token at the time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiep6njm4sf463ume6kq26ysiqutr5y5tizejcx7hhmkmje2dqqmtu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

