module 0x992fd5787c1911baea39535db1ab312df0ba47a307ae92d58325c9355d8af385::treasuire {
    struct TREASUIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREASUIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREASUIRE>(arg0, 6, b"TREASUIRE", b"The Great TREASURE of Sui", b"$TREASUIRE is a token on Sui that represents the hunt for a great treasure. Hidden deep within the Sui seas, it offers immense rewards to those bold enough to seek it. Unlock the riches of $TREASUIRE and claim your fortune!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TREASUIRE_cb4556ed2a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREASUIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREASUIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

