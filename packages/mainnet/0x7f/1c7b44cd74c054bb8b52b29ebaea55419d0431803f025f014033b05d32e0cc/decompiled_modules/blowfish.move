module 0x7f1c7b44cd74c054bb8b52b29ebaea55419d0431803f025f014033b05d32e0cc::blowfish {
    struct BLOWFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOWFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOWFISH>(arg0, 9, b"BLOWFISH", b"BLOWFISH", b"what even is a blowfish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLOWFISH>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOWFISH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOWFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

