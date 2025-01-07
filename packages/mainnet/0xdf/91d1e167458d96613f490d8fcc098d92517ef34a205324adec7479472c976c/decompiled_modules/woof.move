module 0xdf91d1e167458d96613f490d8fcc098d92517ef34a205324adec7479472c976c::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 9, b"WOOF", b"WOOF", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1M8TFzdRPoVwRWVd9t7q-7rcb-nIPfGRpiAiVY45v-T_TCFsK-8zUCDylYGnAxIT6KGw&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOOF>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

