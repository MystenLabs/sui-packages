module 0xf58a7820aab7249535dbba9226483406089ba182b5b84b649a6830e3fa5fc7ef::blaze {
    struct BLAZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAZE>(arg0, 6, b"Blaze", b"Blaze on Sui", b"DO NOT BUY THIS ONE! OFFICIAL LAUNCH IS 09/29 12PM UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blaze_profile_433bfa220a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

