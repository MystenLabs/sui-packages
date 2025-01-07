module 0xc3d87691d3aea04589535bc5b30760390b75b36fc1456abf98a9fff9d95d2a95::cody {
    struct CODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODY>(arg0, 6, b"CODY", b"Sui Cody", b"$CODY is a revolutionary meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_60_0edf750ed5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODY>>(v1);
    }

    // decompiled from Move bytecode v6
}

