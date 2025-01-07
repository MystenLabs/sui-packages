module 0x237629ef3ff81f08838b60b0c65a5b0d91de3063fb6a23638837893ad8953f85::sujo {
    struct SUJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUJO>(arg0, 6, b"Sujo", b"Sui Jojo", b"cutest dog on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUJO_5_d59ffb3f23.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

