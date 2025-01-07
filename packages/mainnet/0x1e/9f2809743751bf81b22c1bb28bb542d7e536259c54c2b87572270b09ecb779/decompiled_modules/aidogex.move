module 0x1e9f2809743751bf81b22c1bb28bb542d7e536259c54c2b87572270b09ecb779::aidogex {
    struct AIDOGEX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIDOGEX>, arg1: 0x2::coin::Coin<AIDOGEX>) {
        0x2::coin::burn<AIDOGEX>(arg0, arg1);
    }

    fun init(arg0: AIDOGEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDOGEX>(arg0, 9, b"AIDOGEX", b"AI DOGEX", b"Solar system's cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1683431973215-e753d01729ab3cd2c34d3cd5fe689590.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIDOGEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDOGEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIDOGEX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIDOGEX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

