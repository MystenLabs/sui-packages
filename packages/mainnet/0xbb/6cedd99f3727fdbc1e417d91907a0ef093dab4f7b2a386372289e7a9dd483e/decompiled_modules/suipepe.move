module 0xbb6cedd99f3727fdbc1e417d91907a0ef093dab4f7b2a386372289e7a9dd483e::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUIPEPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIPEPE>>(arg0, arg1);
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 6, b"SUIPEPE", b"SUIPEPE", b"SUIPEPE is the new blueChip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.discordapp.net/attachments/937594066600878110/1104104003308105778/descargar.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPEPE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

