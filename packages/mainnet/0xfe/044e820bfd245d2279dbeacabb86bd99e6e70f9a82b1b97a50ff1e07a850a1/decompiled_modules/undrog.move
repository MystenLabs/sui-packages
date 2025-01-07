module 0xfe044e820bfd245d2279dbeacabb86bd99e6e70f9a82b1b97a50ff1e07a850a1::undrog {
    struct UNDROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNDROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNDROG>(arg0, 6, b"UNDROG", b"Under Drive Dog", b"we have sam time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_164647_b8829c19d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNDROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNDROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

