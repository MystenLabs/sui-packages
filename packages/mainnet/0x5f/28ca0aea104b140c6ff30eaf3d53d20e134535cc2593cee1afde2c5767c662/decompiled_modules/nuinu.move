module 0x5f28ca0aea104b140c6ff30eaf3d53d20e134535cc2593cee1afde2c5767c662::nuinu {
    struct NUINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUINU>(arg0, 9, b"NUINU", b"Neuroinu", b"Game in Neurons", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://neuroinu.com")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUINU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUINU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

