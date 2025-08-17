module 0x3a921587df7e8c0bdd7a57da4083cdf5239fe0b2a765dbab7ba2b3e92d1331c3::nymi {
    struct NYMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYMI>(arg0, 9, b"NYMI", b"Nigger You Made it", b"https://x.com/i/communities/1957129010749612329", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NYMI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYMI>>(v2, @0x7731aa25eb1f3ad381ecbd9293b2436c4dd1e14a9376086e2de0cd62725dfb5c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

