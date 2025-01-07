module 0x84b0f632af5b0ad3aa455069d93eb7ed1286ead94d07ab587b19750220cdd05b::KONK {
    struct KONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONK>(arg0, 9, b"KONK", b"CAT WIF GUN", b"KONK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1750689090347978752/L-qyw6tS_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KONK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KONK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KONK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

