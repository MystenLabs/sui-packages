module 0x5395bc4e5218a2cf8dfae89a7af40461e34fb91ae1232c1355c2bb906e8f9e14::sui4ai {
    struct SUI4AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI4AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI4AI>(arg0, 9, b"SUI4AI", b"SUI4AI", b"SUI4AI is a groundbreaking token built on the Sui blockchain, designed to revolutionize the integration of artificial intelligence (AI) and blockchain technology. By leveraging the high-performance capabilities of the Sui network, SUI4AI facilitates seamless, scalable, and efficient transactions, empowering developers and businesses to build cutting-edge AI-driven applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1876182351530889216/WaQpA65d_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI4AI>(&mut v2, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI4AI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI4AI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

