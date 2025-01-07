module 0xf7ec7f5fc782b676bb5e5f7a67f46cf0d18b0e577bd470bb3c8310470f7c9cb3::blu {
    struct BLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLU>(arg0, 9, b"BLU", b"Jewelz Blu", b"Jewelz Blu is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static-cdn.jtvnw.net/jtv_user_pictures/922de33b-735d-4818-b54c-975dcdbeb867-profile_image-300x300.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLU>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

