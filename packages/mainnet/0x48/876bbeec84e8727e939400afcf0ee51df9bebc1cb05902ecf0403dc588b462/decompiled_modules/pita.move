module 0x48876bbeec84e8727e939400afcf0ee51df9bebc1cb05902ecf0403dc588b462::pita {
    struct PITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PITA>(arg0, 9, b"PITA", b"Pita", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PITA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

