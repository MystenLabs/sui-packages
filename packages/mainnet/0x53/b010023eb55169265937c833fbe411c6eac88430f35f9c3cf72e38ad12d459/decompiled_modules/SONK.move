module 0x53b010023eb55169265937c833fbe411c6eac88430f35f9c3cf72e38ad12d459::SONK {
    struct SONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONK>(arg0, 9, b"SONK", b"SONK", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONK>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SONK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SONK>>(0x2::coin::mint<SONK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

