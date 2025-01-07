module 0x2949ab02d0cb3fee6db179586dafc60be9943769d8ce3bf7f59b9b76876ca379::boredsui {
    struct BOREDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOREDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOREDSUI>(arg0, 9, b"BOREDSUI", b"Bored Ape on SUI", b"ee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOREDSUI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOREDSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOREDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

