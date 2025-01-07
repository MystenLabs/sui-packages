module 0xdbd784b17f5ff9d644664c89a52200d77d2655d0516eefe6c45cca034db3c334::suimen {
    struct SUIMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEN>(arg0, 6, b"Suimen", b"SUIMEN", b"hero of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jpegozan_33b95426b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

