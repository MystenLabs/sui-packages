module 0x3976580cca41faeac406900a68f428bbbf398ec9bb7b46424ec27e116c4a26a2::dtuyg {
    struct DTUYG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTUYG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTUYG>(arg0, 6, b"DTUYG", b"5toyp", b"X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigjzslbkzhrgab3poznnjqwx72fngynrsxnrgdvyxib5x33r4bzga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTUYG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DTUYG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

