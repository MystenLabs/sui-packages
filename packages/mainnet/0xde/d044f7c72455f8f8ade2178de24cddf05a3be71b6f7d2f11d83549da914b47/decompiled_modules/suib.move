module 0xded044f7c72455f8f8ade2178de24cddf05a3be71b6f7d2f11d83549da914b47::suib {
    struct SUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIB>(arg0, 9, b"SUIB", b"Suiba Inu", b"Emerging from Shiba's boundless love, Suiba, your liquid companion, journeys with you on the Sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.suibacoin.com/suiba.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

