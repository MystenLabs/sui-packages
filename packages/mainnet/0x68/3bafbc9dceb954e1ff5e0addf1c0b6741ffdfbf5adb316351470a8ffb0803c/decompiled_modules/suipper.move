module 0x683bafbc9dceb954e1ff5e0addf1c0b6741ffdfbf5adb316351470a8ffb0803c::suipper {
    struct SUIPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPPER>(arg0, 6, b"SUIPPER", b"Sweeper On Sui", b"$Suipper sweeping the lows and the poor solana devs rugging in sui blockchain left and right. Time to end these n*ggas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_12_100751_removebg_preview_5c19c30d1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

