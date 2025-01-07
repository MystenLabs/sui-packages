module 0x8a33ed48fb1b308f4725d3921342b3eea7cf0a30e112baadad10c5f73f1cb5db::bufc {
    struct BUFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUFC>(arg0, 9, b"BUFC", b"Buff coin", b"Buff coin for Buff profits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUFC>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUFC>>(v2, @0x568e0a82c0329a3c7ef15facbeeaf51cb7e336ae517cbf0a20fa47e0cb4016d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

