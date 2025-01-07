module 0x1816389eb8033fe77aa56c5a38fd38d926c059672742a91563c02abe713a8b2a::msui {
    struct MSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSUI>(arg0, 6, b"MSUI", b"Major SUI", b"The memecoin youll regret not buying before it inevitably becomes the next big thingor crashes spectacularly. Either way, you're here for the ride. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mjsui_8f7ccdbe98.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

