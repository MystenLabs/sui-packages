module 0x3abb542dae1cc4e8d94b9158d018975353c848022dbbd83833b69faa15fcc2cb::jelly {
    struct JELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLY>(arg0, 6, b"JELLY", b"Sui Jelly", b"$JELLY is coming for the top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_21_032e462dc7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

