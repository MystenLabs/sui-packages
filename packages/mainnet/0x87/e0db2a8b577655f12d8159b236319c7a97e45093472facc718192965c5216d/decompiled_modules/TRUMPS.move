module 0x87e0db2a8b577655f12d8159b236319c7a97e45093472facc718192965c5216d::TRUMPS {
    struct TRUMPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPS>(arg0, 9, b"TRUMPS", b"TRUMPS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMPS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMPS>>(0x2::coin::mint<TRUMPS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

