module 0x559dacc95ef25d56d3c38ddc3d9be16a376724a5c183be7c82db8a7101614b5d::tt64 {
    struct TT64 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT64, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT64>(arg0, 9, b"TT64", b"Tamtran", b"miss him", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e13a855-4c1a-401b-8c57-72ac8c4acc5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT64>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TT64>>(v1);
    }

    // decompiled from Move bytecode v6
}

