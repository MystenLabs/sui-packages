module 0xe78cc27e54bb86a97014789282ef62adef0acfc5d2455cd9aa9f798e555e52ee::arsoncat {
    struct ARSONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARSONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARSONCAT>(arg0, 6, b"ArsonCat", b"Arson Cat", b"Phantom Wallet has announced its support for the sui Network, We Will Be Great Again, and now starts the fire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmexport1733497813815_0088d5cf55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARSONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARSONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

