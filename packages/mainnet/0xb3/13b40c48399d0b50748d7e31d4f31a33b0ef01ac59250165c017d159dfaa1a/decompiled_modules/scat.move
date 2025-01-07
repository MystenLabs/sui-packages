module 0xb313b40c48399d0b50748d7e31d4f31a33b0ef01ac59250165c017d159dfaa1a::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 9, b"SCAT", b"Scuba Cat", b"Diving into Oceans of Cuteness,the most adorable cat on Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/NKC5j5f/BDT-2.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v2, @0x3aa8777f918395462fe6ba7c146e584f0ee7d4feb93da2d6541e2158f223ee80);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

