module 0xcb50f44408b9fd0ee3c1fd410846c95969c7a6f547124471e059676dc398ad01::usbtc_mmyn792u572o {
    struct USBTC_MMYN792U572O has drop {
        dummy_field: bool,
    }

    fun init(arg0: USBTC_MMYN792U572O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USBTC_MMYN792U572O>(arg0, 9, b"USBTC", b"U.S Bitcoin Reserve", b"United States Bitcoin Reserve", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmY83TuPd7b5k1gDNcEiHrPhfj4SrexPnW55Qh4bMSigKk")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USBTC_MMYN792U572O>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USBTC_MMYN792U572O>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

