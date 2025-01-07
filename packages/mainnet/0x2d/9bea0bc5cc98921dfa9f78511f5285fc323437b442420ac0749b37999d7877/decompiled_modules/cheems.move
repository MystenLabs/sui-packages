module 0x2d9bea0bc5cc98921dfa9f78511f5285fc323437b442420ac0749b37999d7877::cheems {
    struct CHEEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEMS>(arg0, 6, b"Cheems", b"Cheems on SUI", b"Cheems on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cheems_OG_6745b5cd7f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

