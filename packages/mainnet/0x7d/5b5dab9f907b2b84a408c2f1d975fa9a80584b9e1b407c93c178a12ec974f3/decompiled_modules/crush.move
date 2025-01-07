module 0x7d5b5dab9f907b2b84a408c2f1d975fa9a80584b9e1b407c93c178a12ec974f3::crush {
    struct CRUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUSH>(arg0, 9, b"CRUSH", b"Cherry Crush", b"Crerry Crush is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.scdn.co/image/ab67616d0000b273b7cd976475dc1787ec4db809")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CRUSH>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUSH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

