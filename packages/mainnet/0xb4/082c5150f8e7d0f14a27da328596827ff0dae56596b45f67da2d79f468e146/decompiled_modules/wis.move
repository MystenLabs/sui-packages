module 0xb4082c5150f8e7d0f14a27da328596827ff0dae56596b45f67da2d79f468e146::wis {
    struct WIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIS>(arg0, 6, b"WIS", b"Dog Wif Sui", b"send this cute dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f9_Fat1r_E_400x400_d57dfd1799.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

