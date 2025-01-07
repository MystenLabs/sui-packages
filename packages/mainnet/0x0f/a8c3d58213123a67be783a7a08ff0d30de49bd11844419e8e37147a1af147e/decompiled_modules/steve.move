module 0xfa8c3d58213123a67be783a7a08ff0d30de49bd11844419e8e37147a1af147e::steve {
    struct STEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEVE>(arg0, 6, b"STEVE", b"Steve by Matt Furie", x"537465766520697320616e206f726967696e616c2063686172616374657220696e737069726564206279204d617474204675726965277320426f79277320436c756220436f6d69632e0a0a486520697320796f7572206c6f63616c2064727567206465616c65722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PHYCKFZW_400x400_20e1f2373d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

