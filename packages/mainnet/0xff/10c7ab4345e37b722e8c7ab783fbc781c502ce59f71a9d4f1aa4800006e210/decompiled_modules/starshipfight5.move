module 0xff10c7ab4345e37b722e8c7ab783fbc781c502ce59f71a9d4f1aa4800006e210::starshipfight5 {
    struct STARSHIPFIGHT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARSHIPFIGHT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARSHIPFIGHT5>(arg0, 6, b"Starshipfight5", b"starship fight 5", b"https://x.com/elonmusk/photo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KX_4d2j_XG_400x400_2840258839.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARSHIPFIGHT5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARSHIPFIGHT5>>(v1);
    }

    // decompiled from Move bytecode v6
}

