module 0x1470ab5110f9cc7670d6d83c5207cb053bb73f7ad03f97a56fb9fb30af0c0854::broccoli {
    struct BROCCOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCCOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCCOLI>(arg0, 9, b"BROCCOLI", b"BROCCOLI ON SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/1nvxBhjizmBcSieO")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BROCCOLI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROCCOLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCCOLI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

