module 0xbd9982d82e24a8a6817a36ebde30524b547197c6c681717f23472487638c709e::wp {
    struct WP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WP>(arg0, 9, b"WP", b"whatsup", b"greatart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d2166d85fabb33188486f4dab1f3d17eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

