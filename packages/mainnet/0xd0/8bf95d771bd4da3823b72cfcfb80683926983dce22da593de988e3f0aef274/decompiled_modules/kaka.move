module 0xd08bf95d771bd4da3823b72cfcfb80683926983dce22da593de988e3f0aef274::kaka {
    struct KAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKA>(arg0, 6, b"KAKA", b"KAKA the SUI AI Agent", b"AI Marketing Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1287_c11f76acfd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

