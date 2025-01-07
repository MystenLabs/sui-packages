module 0x2b48a4b827c441dcb2fcb739f128a4a11d0ef7691ca817c3e645373e55f383aa::riley {
    struct RILEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RILEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RILEY>(arg0, 9, b"riley", b"Riley Reid", b"Riley Reid is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://preview.redd.it/riley-reid-v0-2eqfwiljz1bd1.jpeg?width=640&crop=smart&auto=webp&s=32cbba8ddeca7db6839b348c724ecefbda45e6fa")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RILEY>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RILEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RILEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

