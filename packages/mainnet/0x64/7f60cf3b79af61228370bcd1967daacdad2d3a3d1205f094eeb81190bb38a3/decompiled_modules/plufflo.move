module 0x647f60cf3b79af61228370bcd1967daacdad2d3a3d1205f094eeb81190bb38a3::plufflo {
    struct PLUFFLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUFFLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUFFLO>(arg0, 6, b"Plufflo", b"Plufflo token", b"the meme coin that brings fun and finance together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_223028_f6abc64296_78c83b1fe9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUFFLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUFFLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

