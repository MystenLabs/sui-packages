module 0x8ef1e8904dc844a701e21b9d024abbd66607a48d00dfdb844290832aa20a19ff::suinnie {
    struct SUINNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINNIE>(arg0, 6, b"SUINNIE", b"Suinnie The Pooh ", b"Suinnie The Pooh not having to double check his address because he uses SuiNS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731358904644.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINNIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINNIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

