module 0x693026280f787ad6ebe5dd85beff4dd1e884058bcc9b0cc09ba331da34e704::moraysui {
    struct MORAYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORAYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORAYSUI>(arg0, 6, b"MORAYSUI", b"S U I M O R A Y", b"MORAYSUI BLUMOVE LIQUIDITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MORAYSUI>(&mut v2, 690000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORAYSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORAYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

