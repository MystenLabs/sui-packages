module 0x8b90dff5d418b5e1bf9895438b2f3fb5aca7c19dc3e2992ca195916a0d22a538::kiki {
    struct KIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKI>(arg0, 6, b"KIKI", b"KIKI on SUI", x"6b696b692c20646f2075206c7576206d653f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_Juo_JT_Iz_400x400_0406806aee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

