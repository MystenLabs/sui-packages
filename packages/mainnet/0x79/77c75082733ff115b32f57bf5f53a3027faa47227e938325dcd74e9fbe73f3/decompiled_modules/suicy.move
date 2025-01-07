module 0x7977c75082733ff115b32f57bf5f53a3027faa47227e938325dcd74e9fbe73f3::suicy {
    struct SUICY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICY>(arg0, 6, b"SUICY", b"SUICY the Seal", b"Meet Suicy the Seal, the coolest mascot on the Sui blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_Ymkh_Xx_B_400x400_07d5dd6a23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICY>>(v1);
    }

    // decompiled from Move bytecode v6
}

