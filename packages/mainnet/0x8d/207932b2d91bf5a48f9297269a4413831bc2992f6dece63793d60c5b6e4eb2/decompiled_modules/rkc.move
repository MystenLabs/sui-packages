module 0x8d207932b2d91bf5a48f9297269a4413831bc2992f6dece63793d60c5b6e4eb2::rkc {
    struct RKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RKC>(arg0, 9, b"RKC", b"RICHKY", b"Funny ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10ddb150-df05-493c-ae4b-2067256171e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

