module 0xc62ccd92f502ab48b5a3f90a532aac5d957027050022411ff7976a3f981edada::kwitty {
    struct KWITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWITTY>(arg0, 6, b"KWITTY", b"Kwitty", b"Kwitty is a community of NFT enthusiasts, crypto nomads, independent creators, smart investors and beautiful people On SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5307111cbf01de5eea6e082a07e0fbae_5508fd0f8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KWITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

