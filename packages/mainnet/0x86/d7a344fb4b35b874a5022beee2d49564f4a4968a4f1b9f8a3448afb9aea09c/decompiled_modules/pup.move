module 0x86d7a344fb4b35b874a5022beee2d49564f4a4968a4f1b9f8a3448afb9aea09c::pup {
    struct PUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUP>(arg0, 9, b"PUP", b"pumpkin", b"For the new year full of changes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f53faa2-543b-4763-b168-ea00d417bd0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

