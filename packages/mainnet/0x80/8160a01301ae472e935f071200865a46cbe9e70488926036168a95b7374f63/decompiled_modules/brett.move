module 0x808160a01301ae472e935f071200865a46cbe9e70488926036168a95b7374f63::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 6, b"BRETT", b"BREET ON SUI", b"Relounch Brett Chillin' like a champ as usual. Brett from Boy's club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000075267_f4466dd3ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

