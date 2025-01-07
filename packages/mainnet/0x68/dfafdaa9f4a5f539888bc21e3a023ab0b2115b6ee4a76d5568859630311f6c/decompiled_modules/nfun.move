module 0x68dfafdaa9f4a5f539888bc21e3a023ab0b2115b6ee4a76d5568859630311f6c::nfun {
    struct NFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFUN>(arg0, 6, b"NFUN", b"Hop No Fun", b"We have all watched how Hop's delay has made the memes stale. Let's change that with Hop No Fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hop_No_Fun_1_85bd7232c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

