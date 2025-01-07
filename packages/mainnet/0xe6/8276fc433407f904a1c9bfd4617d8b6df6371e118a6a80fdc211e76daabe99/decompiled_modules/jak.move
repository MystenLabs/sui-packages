module 0xe68276fc433407f904a1c9bfd4617d8b6df6371e118a6a80fdc211e76daabe99::jak {
    struct JAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAK>(arg0, 6, b"JAK", b"BOJAK", b"It's Bojak.  On Sui.  And he's Sui.  Like Super Sui! SoBojak ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zk_R2wi_Xc_Asy_Rdt_8424cbed4b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

