module 0xe3cd2c96ff5360c645dcb6ab6e786156bcb8618c38cf2c29764ce957ce0983ff::six {
    struct SIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIX>(arg0, 9, b"SIX", b"69 team", b"i love 69", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/066cbae85b341f174b2930ca050b94e1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

