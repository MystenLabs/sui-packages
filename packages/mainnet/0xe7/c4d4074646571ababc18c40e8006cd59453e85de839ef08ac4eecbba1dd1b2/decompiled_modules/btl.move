module 0xe7c4d4074646571ababc18c40e8006cd59453e85de839ef08ac4eecbba1dd1b2::btl {
    struct BTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTL>(arg0, 9, b"BTL", b"Bottle", b"Bottle meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93484f8a-4121-44c3-b5d0-fe37c02d8ae4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

