module 0x486e39fd0023477cf7c0406a98aecf7c1a3f0277fb01900d065808508a43a4fc::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLATE>(arg0, 6, b"LAUNCH", b"SuiPump Token (initializing)", b"This token was published but its launch was not completed, so its name, symbol and image are still placeholders. If you are the creator, return to suipump.org to finish the launch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipump.org/token-initializing.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMPLATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

