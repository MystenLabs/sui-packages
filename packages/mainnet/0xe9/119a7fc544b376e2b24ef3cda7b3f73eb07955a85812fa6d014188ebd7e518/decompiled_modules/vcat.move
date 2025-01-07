module 0xe9119a7fc544b376e2b24ef3cda7b3f73eb07955a85812fa6d014188ebd7e518::vcat {
    struct VCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCAT>(arg0, 6, b"VCat", b"Sui Video Cat", b"Building high quality Video Cat meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731578344922.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

