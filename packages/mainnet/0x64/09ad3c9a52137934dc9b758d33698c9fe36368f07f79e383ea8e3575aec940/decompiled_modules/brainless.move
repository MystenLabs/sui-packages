module 0x6409ad3c9a52137934dc9b758d33698c9fe36368f07f79e383ea8e3575aec940::brainless {
    struct BRAINLESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAINLESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAINLESS>(arg0, 6, b"BRAINLESS", b"Brainless Fwog", b"Help cus my brain not wurking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/brainless_889f977465.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINLESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAINLESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

