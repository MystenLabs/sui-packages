module 0x77b3e2e6965b87c57cb496414e3475e663fa50bafee92b12ee3a707da25d130::sheesh {
    struct SHEESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEESH>(arg0, 6, b"SHEESH", b"Sheesh on Sui", b"Sheesh! Chill out bro. Yea, you've found a gem. Yea, you'll have enough money for that lambo you always dreamt of. Yes, yes, you can feed your village. Sheesh. Just join us already...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_197df88798.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

