module 0x86db175aba6e09cbe45391098e4660fce1cb2e5d3e556674517112c428621c4f::ikby {
    struct IKBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKBY>(arg0, 9, b"Ikby", b"Ika baby", b"In the future Ika will have a branch coming out of it, Ika baby.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/38b8aff61028bf781ddfc2dfe0e1ccf6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKBY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

