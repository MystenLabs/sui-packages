module 0x507cfd187a595c8c181485275cb3a8fe04b5e1818d65a8fd8b9ac7c61a96109e::spacex {
    struct SPACEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACEX>(arg0, 6, b"SpaceX", b"SpaceX on SUI", b"Introducing SpaceX Token on the SUI blockchain!  Experience the fusion of innovation and cutting-edge technology as we redefine the crypto space. Powered by SUIs high-speed performance, SpaceX Token is your gateway to a decentralized future. Join the mission today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3976_0a4ac6f4df.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPACEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

