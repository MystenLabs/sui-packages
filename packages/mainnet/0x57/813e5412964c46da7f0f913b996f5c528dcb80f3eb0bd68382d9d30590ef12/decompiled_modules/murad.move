module 0x57813e5412964c46da7f0f913b996f5c528dcb80f3eb0bd68382d9d30590ef12::murad {
    struct MURAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURAD>(arg0, 6, b"MURAD", b"Murad Flanders", b"Im Murad Flanders  meme messiah, CT king. I dont follow trends  I am the trend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048411_a3efcb1403.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

