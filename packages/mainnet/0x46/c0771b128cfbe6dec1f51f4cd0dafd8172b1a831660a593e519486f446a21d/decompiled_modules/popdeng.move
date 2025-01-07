module 0x46c0771b128cfbe6dec1f51f4cd0dafd8172b1a831660a593e519486f446a21d::popdeng {
    struct POPDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDENG>(arg0, 6, b"POPDENG", b"POPDENG sui", b"Meet Pop Deng, the wild offspring of Pop Cat and Mooondeng! Born from the legendary union of a $1.2B market cap and a $300M moonshot, Pop Deng is here to make its own splash on the Sui blockchain. With the best of both worldsmeme madness and moon-bound ambitionPop Deng is ready to pounce and pop its way to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pop_bf0d62f55e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

