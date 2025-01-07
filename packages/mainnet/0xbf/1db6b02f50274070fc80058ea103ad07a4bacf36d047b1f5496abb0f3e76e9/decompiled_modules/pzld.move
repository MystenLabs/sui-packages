module 0xbf1db6b02f50274070fc80058ea103ad07a4bacf36d047b1f5496abb0f3e76e9::pzld {
    struct PZLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PZLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PZLD>(arg0, 6, b"PZLD", b"Ponzi Lords", b"We've all been rekt one time or another, and together we shall come back stronger for it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_11e6a20e0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PZLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PZLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

