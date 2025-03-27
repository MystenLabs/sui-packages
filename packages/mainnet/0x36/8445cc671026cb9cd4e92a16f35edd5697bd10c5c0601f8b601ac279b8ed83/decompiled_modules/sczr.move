module 0x368445cc671026cb9cd4e92a16f35edd5697bd10c5c0601f8b601ac279b8ed83::sczr {
    struct SCZR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCZR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCZR>(arg0, 6, b"SCZR", b"Strategic CZ Reserve", b"Changpeng Zhao? By stockpiling CZ and his unparalleled ability to fund SAFU,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076251_42f0e990b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCZR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCZR>>(v1);
    }

    // decompiled from Move bytecode v6
}

