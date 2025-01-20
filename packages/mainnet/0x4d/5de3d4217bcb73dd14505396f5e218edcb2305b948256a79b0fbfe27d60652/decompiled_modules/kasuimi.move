module 0x4d5de3d4217bcb73dd14505396f5e218edcb2305b948256a79b0fbfe27d60652::kasuimi {
    struct KASUIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KASUIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KASUIMI>(arg0, 6, b"KASUIMI", b"KASUIMI GIRL", b"I'm just your best friend in Sui ^_^", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logoback_81b5c8ebbb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KASUIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KASUIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

