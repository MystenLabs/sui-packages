module 0x6cb13824894276efb7154a2c9bc45311a742f84f8e8eb9bcff307105be33d4::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"Goat Trading", b"Goat Trading has created the Dojo launchpad in collaboration with SushiSwap to enable safe and fun memecoin trading. $GOAT serves as the official token for Dojo. Fees generated from trading on Dojo are directly fed back into $GOAT through a buyback and burn mechanism.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GOAT_67de118090.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

