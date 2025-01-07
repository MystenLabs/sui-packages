module 0x49230ba419a8eb8020f411607b2707d064f0e2b2b702c88be0c3e9321ac6acee::spacex {
    struct SPACEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACEX>(arg0, 6, b"SpaceX", b"SpaceX on SUI", b"Introducing SpaceX Token on the SUI blockchain!  Experience the fusion of innovation and cutting-edge technology as we redefine the crypto space. Powered by SUIs high-speed performance, SpaceX Token is your gateway to a decentralized future. Join the mission today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3976_96c91a34a0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPACEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

