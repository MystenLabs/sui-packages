module 0x30429cd3bedb2572aa92e06d6f4da18bb982b6dd810543252581faba0372bfcb::suilama {
    struct SUILAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMA>(arg0, 9, b"SUILAMA", b"SuiLama", b"Sui Lama Meme Token On SUI ChaIn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x5a4f64079daed04d923c93f3ac4ee04b637e5b3ea2db87d591981c1049508a27::suilama::suilama.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILAMA>(&mut v2, 466000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

