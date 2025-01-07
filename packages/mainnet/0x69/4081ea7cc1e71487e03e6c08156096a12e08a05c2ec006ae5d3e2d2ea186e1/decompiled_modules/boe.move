module 0x694081ea7cc1e71487e03e6c08156096a12e08a05c2ec006ae5d3e2d2ea186e1::boe {
    struct BOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOE>(arg0, 9, b"BOE", b"BEYONCE", b"Meme beyonce", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/627af39e-3d9d-4cc7-837f-5e7f446a9ac4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

