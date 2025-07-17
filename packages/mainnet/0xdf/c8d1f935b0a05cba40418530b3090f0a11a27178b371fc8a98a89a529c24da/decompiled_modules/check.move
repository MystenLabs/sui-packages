module 0xdfc8d1f935b0a05cba40418530b3090f0a11a27178b371fc8a98a89a529c24da::check {
    struct CHECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHECK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHECK>(arg0, 6, b"CHECK", b"CHECK", b"CHECK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sui_sui_logo_png_01c818bd68.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHECK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHECK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

