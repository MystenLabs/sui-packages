module 0x50d651e581adb3619cd272ae1c3aa6fe6a6f169c7b99d2d02ee1ea1db47dbed::nutty {
    struct NUTTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTTY>(arg0, 9, b"NUTTY", b"PeaNuttz", b"PeaNuttz is an upcoming token launching on the Sui blockchain, designed to leverage Sui's fast and scalable network. It aims to offer functionalities in areas such as decentralized finance (DeFi), governance, and community rewards. With its integration into the growing Sui ecosystem, PeaNuttz seeks to deliver reliable and efficient utility for users, focusing on long-term community-driven growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1788366353977462784/eXzmXyvb.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUTTY>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUTTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

