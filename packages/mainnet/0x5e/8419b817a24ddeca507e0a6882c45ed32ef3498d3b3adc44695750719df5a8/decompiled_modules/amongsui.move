module 0x5e8419b817a24ddeca507e0a6882c45ed32ef3498d3b3adc44695750719df5a8::amongsui {
    struct AMONGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMONGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMONGSUI>(arg0, 6, b"AMONGSUI", b"AMONG on SUI", b"Among Sui - a meme coin inspired by Among Us, built on the Sui blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241011_205032_b21f679c95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMONGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMONGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

