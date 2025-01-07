module 0x1fafe347e9bdb89d1c7f457134cc83271ae69e2915cf02ed4bae26e1cb61c962::suiro {
    struct SUIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRO>(arg0, 9, b"SUIRO", b"Suiro", b"Suiro is a fast, secure token on the SUI blockchain, offering a simple and efficient DeFi experience. Perfect for users seeking innovation and reliability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1836857214801256448/ruyFNsTn.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIRO>(&mut v2, 330000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

