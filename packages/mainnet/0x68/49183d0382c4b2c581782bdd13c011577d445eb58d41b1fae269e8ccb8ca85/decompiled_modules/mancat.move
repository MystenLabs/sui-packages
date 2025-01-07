module 0x6849183d0382c4b2c581782bdd13c011577d445eb58d41b1fae269e8ccb8ca85::mancat {
    struct MANCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANCAT>(arg0, 9, b"MANCAT", b"Mancat", b"Own the streets, own the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1828432227866161152/Mdfjupme_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MANCAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

