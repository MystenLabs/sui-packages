module 0x868b35c2d51f5735e9a6d71cbe61723158f1582361684196d3329c9058f477fd::bosol {
    struct BOSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSOL>(arg0, 6, b"BOSOL", b"Book Of Solana", b"The Holy Book of Solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogsui_73e2269ae2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

