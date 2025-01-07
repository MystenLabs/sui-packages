module 0x9cb0b2502bdea407c4077852779a19f9de52895ceebf8ad731bf05db3361acbe::trb {
    struct TRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRB>(arg0, 6, b"TRB", b"turbo", b"Turbo is now a fully decentralized community-driven crypto adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_22_at_10_28_14a_pm_49e82db59f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

