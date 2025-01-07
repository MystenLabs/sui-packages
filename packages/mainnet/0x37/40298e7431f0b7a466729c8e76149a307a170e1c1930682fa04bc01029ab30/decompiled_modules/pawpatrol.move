module 0x3740298e7431f0b7a466729c8e76149a307a170e1c1930682fa04bc01029ab30::pawpatrol {
    struct PAWPATROL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWPATROL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWPATROL>(arg0, 6, b"PAWPATROL", b"PAWPATROLSUI", b"ntroducing Paw Patrol Family Coin  the newest member of the crypto world for dog lovers and their families!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Ady58_400x400_a32e0f60bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWPATROL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWPATROL>>(v1);
    }

    // decompiled from Move bytecode v6
}

