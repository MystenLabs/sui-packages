module 0xe183c105c3e2d8411c88f7a7b3a14a699afd15dcf5794d385385b8d83acdf90b::injured {
    struct INJURED has drop {
        dummy_field: bool,
    }

    fun init(arg0: INJURED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INJURED>(arg0, 6, b"INJURED", b"Injured Jesus", x"486520676f7420696e6a757265642062792075206b6e6f772077686f2e2e2e0a42757420686520697320616c6976652c20616c6c206865616c65642075702c20616e6420726561647920746f20666967687420686973206e65787420626174746c65206f6e207375692e0a436f6d65204a6f696e20616e6420666967687420616c6f6e677369646520776974682068696d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jrrsuus_293f73972e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INJURED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INJURED>>(v1);
    }

    // decompiled from Move bytecode v6
}

