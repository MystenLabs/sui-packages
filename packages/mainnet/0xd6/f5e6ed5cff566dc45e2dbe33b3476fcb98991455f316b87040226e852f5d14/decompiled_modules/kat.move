module 0xd6f5e6ed5cff566dc45e2dbe33b3476fcb98991455f316b87040226e852f5d14::kat {
    struct KAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAT>(arg0, 6, b"KAT", b"K4TS", b"For the Cats lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731009595056.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

