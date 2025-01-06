module 0xf5065994883eb931b7e20d0aee086816d6af14c332cba471abfb6e16dba87d33::hyper {
    struct HYPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPER>(arg0, 9, b"HYPER", b"HYPER", b"HYPER is a platform that empowers users to build and customize virtual experiences, fostering creativity, collaboration, and community engagement.HYPER by integrating with the Sui blockchain, Hyperfy leverages Sui's high-performance, scalable infrastructure to enhance the security and efficiency of digital asset ownership within its virtual spaces.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1872950790471729155/k2t2yWRQ_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HYPER>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPER>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

