module 0x8cdeabff77c6f498fcde0ff92db2358116392b7d17192125172be8203f035222::ds {
    struct DS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DS>(arg0, 6, b"DS", b"Digsui", b"Dig's secret to success Always keep your head up!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/exeggcute_use_tackle_0390561d07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DS>>(v1);
    }

    // decompiled from Move bytecode v6
}

