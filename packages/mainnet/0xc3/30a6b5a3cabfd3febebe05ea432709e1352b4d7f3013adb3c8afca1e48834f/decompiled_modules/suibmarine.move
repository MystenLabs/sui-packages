module 0xc330a6b5a3cabfd3febebe05ea432709e1352b4d7f3013adb3c8afca1e48834f::suibmarine {
    struct SUIBMARINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBMARINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBMARINE>(arg0, 9, b"SUIBMARINE", b"Suibmarine", b"Emerging from the depths", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.pngtree.com%2Ffreepng%2Fsubmarine-blue-cute-cartoon-style_6937756.html&psig=AOvVaw1F5746ZbPbwD20J7K4CiAK&ust=1726196326321000&source=images&cd=vfe&opi=89978449&ved=0CA8QjRxqFwoTCKDNhsq0vIgDFQAAAAAdAAAAABAE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBMARINE>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBMARINE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBMARINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

