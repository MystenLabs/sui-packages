module 0xbd4ef925eb6feb2e70788742959c81434d297c17292bf59d79e2b02256699f4::women {
    struct WOMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOMEN>(arg0, 6, b"WOMEN", b"SUIWOMEN", x"535549574f4d454e0a4f4e204849532057415920544f20534156452043525950544f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000198291_064e075cba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

