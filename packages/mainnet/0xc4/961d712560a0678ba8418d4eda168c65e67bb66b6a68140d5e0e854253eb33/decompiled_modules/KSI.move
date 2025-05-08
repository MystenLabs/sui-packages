module 0xc4961d712560a0678ba8418d4eda168c65e67bb66b6a68140d5e0e854253eb33::KSI {
    struct KSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSI>(arg0, 6, b"KSI", b"Baldski", b"throwback BALDSKI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmQ9DBj9aefurArF4vDrNdzXFJDD1y2V5hd4cUgVpDEPcH")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

