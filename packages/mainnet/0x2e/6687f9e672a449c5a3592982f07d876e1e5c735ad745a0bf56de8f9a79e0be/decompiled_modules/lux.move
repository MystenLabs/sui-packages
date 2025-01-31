module 0x2e6687f9e672a449c5a3592982f07d876e1e5c735ad745a0bf56de8f9a79e0be::lux {
    struct LUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUX>(arg0, 9, b"LUX", b"Lux Token", b"The Multiplayer Internet, A Unified Way to Navigate the Internet on Blockchain Technology. Unlock Multiplayer Browsing. Explore a Digital Universe Composed of Shared Online Spaces.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbyGqbDnihx1rcXw3UxE5S3JsBC73vJPEFzbB6QzsD4oa")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

