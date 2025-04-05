module 0xd385c7503ec0a5308af7c43423d8a5dc80735acd507b0394c8d0a68596ec725b::vkng {
    struct VKNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: VKNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VKNG>(arg0, 9, b"VKNG", b"Viking", b"Token viking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8477609e17b797a40483a6f2846dce64blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VKNG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VKNG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

