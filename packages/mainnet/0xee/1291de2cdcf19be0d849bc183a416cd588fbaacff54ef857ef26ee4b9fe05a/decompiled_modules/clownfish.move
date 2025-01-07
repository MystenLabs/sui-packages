module 0xee1291de2cdcf19be0d849bc183a416cd588fbaacff54ef857ef26ee4b9fe05a::clownfish {
    struct CLOWNFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOWNFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOWNFISH>(arg0, 6, b"CLOWNFISH", b"ClownFish", b"Every transaction looks like a laugh! This meme coin brings humor and joy to cryptocurrency trading, join our underwater party.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/capa_peixe_0782783df0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOWNFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOWNFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

