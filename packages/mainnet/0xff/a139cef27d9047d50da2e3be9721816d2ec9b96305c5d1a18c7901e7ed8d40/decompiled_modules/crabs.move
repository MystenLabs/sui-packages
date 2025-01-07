module 0xffa139cef27d9047d50da2e3be9721816d2ec9b96305c5d1a18c7901e7ed8d40::crabs {
    struct CRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABS>(arg0, 6, b"Crabs", b"Crab", b"King of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ta_i_xua_ng_31ec6b5f2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

