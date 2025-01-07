module 0xa6660ea76fe9cfc14fe893198bc0e59a88163de4b5828d728932aff8d3698d78::sdp {
    struct SDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDP>(arg0, 9, b"SDP", b"Sui Drop", b"Sui Drop created on Wave Memepad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c564a3e5-ed11-4725-8f84-74249fb569f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

