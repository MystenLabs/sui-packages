module 0x9ed8c2c9d130ed6ec6d541ff9b4752b34b66023245f43cc5605780b622bc1728::usds {
    struct USDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDS>(arg0, 9, b"USDS", b"Sui Usd", b"USD On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843783244032159745/nr7_w-5_.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

