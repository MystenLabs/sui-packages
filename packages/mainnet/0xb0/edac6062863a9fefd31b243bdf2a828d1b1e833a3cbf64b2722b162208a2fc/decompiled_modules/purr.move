module 0xb0edac6062863a9fefd31b243bdf2a828d1b1e833a3cbf64b2722b162208a2fc::purr {
    struct PURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURR>(arg0, 6, b"PURR", b"Purrcat Sui", b"Purrcat $PURR is meme token purring of defiance against the dog-eat-dog world of crypto. Here, cat lovers unite, wielding the power of $PURR to conquer dominance!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_97_d14352a45a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURR>>(v1);
    }

    // decompiled from Move bytecode v6
}

