module 0x9e22ed16d02e55ffef255cf5a6e931a419fe7114f8e705a92827c66c63f84c6a::ein {
    struct EIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EIN>(arg0, 9, b"EIN", b"EIN", b"E = MC2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/NSGMfpQ/albert-einstein-sticks-out-his-tongue-when-asked-by-news-photo-1681316749.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

