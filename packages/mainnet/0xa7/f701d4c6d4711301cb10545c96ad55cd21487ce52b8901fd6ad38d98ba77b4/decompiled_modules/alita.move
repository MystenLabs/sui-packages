module 0xa7f701d4c6d4711301cb10545c96ad55cd21487ce52b8901fd6ad38d98ba77b4::alita {
    struct ALITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALITA>(arg0, 6, b"ALITA", b"Alita AI", b"Alita AI, the second AI agent on X, has officially launched on Sui.  Powered by the advanced technology of Moss AI, Alita is designed to enhance decentralized applications and user interactions with smarter, faster, and more efficient solutions. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736091485783.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALITA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALITA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

