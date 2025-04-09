module 0x86acaf523a482fe9a07d994b94672c0bfe580676fdb2d105e4e6ea5f080f3a65::suina {
    struct SUINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINA>(arg0, 6, b"Suina", b"Trump from Suina", b"Suina ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/header_png_5_6349c929b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

