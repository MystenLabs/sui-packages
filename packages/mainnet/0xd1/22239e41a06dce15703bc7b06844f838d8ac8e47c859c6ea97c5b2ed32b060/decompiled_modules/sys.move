module 0xd122239e41a06dce15703bc7b06844f838d8ac8e47c859c6ea97c5b2ed32b060::sys {
    struct SYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SYS>(arg0, 6, b"SYS", b"Mikoshi by SuiAI", b"- Secure your soul -.An data fortress that stores digitized personalities created by AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Mikoshi_86d3203754.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SYS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

