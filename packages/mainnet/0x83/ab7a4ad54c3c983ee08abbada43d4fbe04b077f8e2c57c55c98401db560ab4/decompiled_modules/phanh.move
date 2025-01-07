module 0x83ab7a4ad54c3c983ee08abbada43d4fbe04b077f8e2c57c55c98401db560ab4::phanh {
    struct PHANH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHANH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHANH>(arg0, 9, b"PHANH", b"PHANH name", b"PHANH des", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvTrp5BUe0zBPnQBBWjoUFvEtc26PNgfjWxw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PHANH>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHANH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHANH>>(v1);
    }

    // decompiled from Move bytecode v6
}

