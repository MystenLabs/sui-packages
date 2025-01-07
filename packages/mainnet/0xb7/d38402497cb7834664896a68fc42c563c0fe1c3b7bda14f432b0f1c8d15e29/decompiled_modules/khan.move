module 0xb7d38402497cb7834664896a68fc42c563c0fe1c3b7bda14f432b0f1c8d15e29::khan {
    struct KHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHAN>(arg0, 9, b"KHAN", b"Imran Khan", b"Imran khan is legendary leader of Pakistani nation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5cbbce2-73af-4ddd-a1ea-585b7554283e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

