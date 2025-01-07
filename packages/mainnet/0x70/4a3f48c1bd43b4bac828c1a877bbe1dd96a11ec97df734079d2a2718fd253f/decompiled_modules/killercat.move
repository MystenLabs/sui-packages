module 0x704a3f48c1bd43b4bac828c1a877bbe1dd96a11ec97df734079d2a2718fd253f::killercat {
    struct KILLERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLERCAT>(arg0, 6, b"Killercat", b"Trade Killer Cat", b"meowww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zxb_An9a_AA_Aw5_8_b59f4b97ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILLERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

