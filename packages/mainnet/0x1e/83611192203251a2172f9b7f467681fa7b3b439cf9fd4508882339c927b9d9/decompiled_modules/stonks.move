module 0x1e83611192203251a2172f9b7f467681fa7b3b439cf9fd4508882339c927b9d9::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONKS>(arg0, 6, b"STONKS", b"SuiStonks", b"Based On Stonks MEME on Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suistonk_9956931d23.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

