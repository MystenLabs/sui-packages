module 0xd1b2168cf630cf503517c592c404327ff121261a0e880a13922549a1066c3f66::telon69 {
    struct TELON69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TELON69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TELON69>(arg0, 6, b"TELON69", b"TRUMPELON69", b"Trumpelon69 is a community-driven Meme coin that's all about embracing the changes Trump & Elon Will bring to Make America Great Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730989536509.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TELON69>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TELON69>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

