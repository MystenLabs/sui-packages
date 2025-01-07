module 0x47ba88480ff955507234de99d63e6f63836eed63174085e0df6b6254bda34d26::wem {
    struct WEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEM>(arg0, 6, b"WEM", b"WEM SUI", b"WEM's been a NEET since forever, gaming and chill is his lifestyle since he was a kitten", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_Bu_Uqmpo_400x400_82f014c705.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

