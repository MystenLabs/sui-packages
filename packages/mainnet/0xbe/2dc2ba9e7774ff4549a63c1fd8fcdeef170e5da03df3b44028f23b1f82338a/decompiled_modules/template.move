module 0xbe2dc2ba9e7774ff4549a63c1fd8fcdeef170e5da03df3b44028f23b1f82338a::template {
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

