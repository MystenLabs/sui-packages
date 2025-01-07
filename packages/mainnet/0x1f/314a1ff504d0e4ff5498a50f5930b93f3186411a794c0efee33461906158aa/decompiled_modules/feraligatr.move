module 0x1f314a1ff504d0e4ff5498a50f5930b93f3186411a794c0efee33461906158aa::feraligatr {
    struct FERALIGATR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FERALIGATR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERALIGATR>(arg0, 8, b"FERALIGATR", b"Feraligatr", b"..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTimkvjKJHXzA6eP2wZibrlwbdFncNCD7_cQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FERALIGATR>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERALIGATR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FERALIGATR>>(v1);
    }

    // decompiled from Move bytecode v6
}

