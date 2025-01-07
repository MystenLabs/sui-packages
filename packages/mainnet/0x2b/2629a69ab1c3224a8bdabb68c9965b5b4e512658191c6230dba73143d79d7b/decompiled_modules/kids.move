module 0x2b2629a69ab1c3224a8bdabb68c9965b5b4e512658191c6230dba73143d79d7b::kids {
    struct KIDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIDS>(arg0, 9, b"KIDS", b"Kid", b"FOR THE CULTURE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02b6fcce-a183-4e4a-8c48-58f20c9e259a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

