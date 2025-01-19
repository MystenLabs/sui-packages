module 0x5546c8dca6a532b66e1cc22f690d95b84e26fc6646f62f734d8e152870c31fd::chiefs {
    struct CHIEFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIEFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIEFS>(arg0, 6, b"Chiefs", b"Red Kingdom", b"3 Peat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737262202051.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIEFS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIEFS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

