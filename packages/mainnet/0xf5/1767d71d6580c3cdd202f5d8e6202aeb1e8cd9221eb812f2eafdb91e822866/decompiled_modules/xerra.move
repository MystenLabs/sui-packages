module 0xf51767d71d6580c3cdd202f5d8e6202aeb1e8cd9221eb812f2eafdb91e822866::xerra {
    struct XERRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XERRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XERRA>(arg0, 9, b"XERRA", b"XERRA", b"XERRA is a next-generation cryptocurrency built on the Sui blockchain, a high-performance and scalable Layer-1 platform designed for the future of decentralized applications. Leveraging Sui's innovative Move programming language, XERRA delivers secure, fast, and cost-effective transactions, making it ideal for powering Web3 ecosystems. XERRA is tailored for applications in DeFi, gaming, and NFTs, with a focus on empowering communities and fostering seamless digital ownership in a decentralized world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1875490919513792512/ij7c3IBK_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XERRA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XERRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XERRA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

