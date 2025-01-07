module 0x83cf44e4696b6421d39acaa0e0592915856bfcdab05be0caad9fdee6a8539dfb::suck {
    struct SUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCK>(arg0, 6, b"SUCK", b"SUCK SUI", b"$SUCK ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/duck_removebg_preview_1_5710e497ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

