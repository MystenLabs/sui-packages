module 0x850805fd7814fbdfc334eb2fb16e4d240c307605af50338bf96f4d6b75c950bd::suiffer {
    struct SUIFFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFFER>(arg0, 6, b"SUIFFER", b"Suiffer", b"Suiffer - say goodbye to other blockchains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIFFER_ca6ac9d325.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

