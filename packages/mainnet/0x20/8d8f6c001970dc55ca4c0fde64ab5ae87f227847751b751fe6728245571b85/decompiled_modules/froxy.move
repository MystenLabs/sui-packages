module 0x208d8f6c001970dc55ca4c0fde64ab5ae87f227847751b751fe6728245571b85::froxy {
    struct FROXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROXY>(arg0, 6, b"FROXY", b"Froxy", b"The coolest Arctic Fox on the blockchain, bringing frosty vibes and chilly mood.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/643_426e8d6d51.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

