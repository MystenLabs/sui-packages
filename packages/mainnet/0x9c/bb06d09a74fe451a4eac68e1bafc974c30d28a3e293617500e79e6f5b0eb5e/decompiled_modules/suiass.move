module 0x9cbb06d09a74fe451a4eac68e1bafc974c30d28a3e293617500e79e6f5b0eb5e::suiass {
    struct SUIASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIASS>(arg0, 6, b"SUIASS", b"suinetworkass", b"sexiest trenches ass on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750774140829.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

