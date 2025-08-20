module 0x63d85a2d5ee25e9cbb60dea6575456b01c5cd2664c2b01863bcc41b7d14cf66f::RMS {
    struct RMS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RMS>, arg1: 0x2::coin::Coin<RMS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<RMS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RMS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RMS>>(0x2::coin::mint<RMS>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<RMS>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RMS>>(arg0);
    }

    fun init(arg0: RMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMS>(arg0, 9, b"RMS", b"MRS me rewards sui", b"RMS rewards me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_68a5da87971740.42730346.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

