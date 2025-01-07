module 0xe8f87f2869da33688e754ec567ef633324f032da9bf21393adacb67b29f94e24::frug {
    struct FRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUG>(arg0, 6, b"FRUG", b"FRUG on SUI", b"$FRUG was born from the ashes, a true community meme.   ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Oz_Ye7mbp_400x400_12539b3abe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

