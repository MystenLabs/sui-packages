module 0xe56d93c0db4c8f88c9f0a55c541256545c156344dfe8a8aa557b0bb5960b7af::shinu {
    struct SHINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHINU>(arg0, 6, b"Shinu", b"Shark Inu", b"The cutest shark on Sui.. every chain needs a shiba ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5298_1cec0b00ea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

