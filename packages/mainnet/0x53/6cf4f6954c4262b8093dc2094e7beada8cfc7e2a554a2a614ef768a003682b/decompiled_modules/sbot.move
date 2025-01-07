module 0x536cf4f6954c4262b8093dc2094e7beada8cfc7e2a554a2a614ef768a003682b::sbot {
    struct SBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOT>(arg0, 6, b"SBOT", b"SuiBridgeBot", b"$SBOT isnt just another token. Its the key to accessing this innovative bridge, facilitating your transfers with minimal fees and maximum speed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039952_e7fc1b9acd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

