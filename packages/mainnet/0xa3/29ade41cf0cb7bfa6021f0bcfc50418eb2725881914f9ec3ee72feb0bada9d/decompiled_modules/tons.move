module 0xa329ade41cf0cb7bfa6021f0bcfc50418eb2725881914f9ec3ee72feb0bada9d::tons {
    struct TONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONS>(arg0, 9, b"TONS", b"TON x SUI", b"TON X SUI NETWORK COLAB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3c4854a93a41ac4befe955e1c54c3da8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

