module 0xda7212c3f64c5839a812ad12948848531534e622b4d0fb73a23af06fa2a2ffa5::scap {
    struct SCAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAP>(arg0, 9, b"SCAP", b"Small Cap Dao", b"A decentralized community of investors collectively seizing the best opportunities in the AI agents and memecoins market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/72db1550-da3f-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAP>>(v1);
        0x2::coin::mint_and_transfer<SCAP>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

