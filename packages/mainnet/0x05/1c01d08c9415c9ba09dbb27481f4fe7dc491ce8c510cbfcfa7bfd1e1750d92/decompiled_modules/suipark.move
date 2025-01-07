module 0x51c01d08c9415c9ba09dbb27481f4fe7dc491ce8c510cbfcfa7bfd1e1750d92::suipark {
    struct SUIPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPARK>(arg0, 6, b"SUIPARK", b"Sui Park", b"I'm goin' down to South Park gonna have myself a time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suuiipark_f9f20bfa6f.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

