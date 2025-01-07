module 0xee7085d5895e27eecff4b0ab826f3fc4b08c163baa35fb75086fb4bb144ab6d2::kuaisu {
    struct KUAISU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUAISU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUAISU>(arg0, 6, b"Kuaisu", b"SuiKuaisu", b"Ride the wave of Kuaisu! #GlubGlub", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_SR_La_Pit_400x400_d8f9082e7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUAISU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUAISU>>(v1);
    }

    // decompiled from Move bytecode v6
}

