module 0xaf089b021a95f438d8319c0ec767a2be0f0eedd1d4c313880044e0d6b6fb4702::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 6, b"PENGU", b"Sui Pengu", b"PENGU is a funny penguin who's balls are deep in jeets mouth. He slides into SUI Network with pure confidence to show whos the boss.  If you're not vibing with PENGUs wild art jams, then just KYS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1080_x_1080_px_3_d125fa2dd2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

