module 0x5248e68c70d4952860f0ac356ab6ee1125045b032ef2719aa46ae3998feb9470::trez {
    struct TREZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREZ>(arg0, 8, b"TREZ", b"Tree for the planet Earth", b"TREZ is the governance token for TRZ-protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TREZ>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREZ>>(v2, @0xc1e3eb64981a7db8378e77de783ef3834820715e3905d5c12dedfcdde7a571f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

