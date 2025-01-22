module 0xfa448d0efcfee3e18ae85410fa317ecec53ea4af3c4e1633334ce6e17d3c5cde::teto {
    struct TETO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETO>(arg0, 4, b"TETO", b"Test token 1 ", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/d8351930-d870-11ef-89e2-d9659b0da29b")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TETO>>(v1);
        0x2::coin::mint_and_transfer<TETO>(&mut v2, 11000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

