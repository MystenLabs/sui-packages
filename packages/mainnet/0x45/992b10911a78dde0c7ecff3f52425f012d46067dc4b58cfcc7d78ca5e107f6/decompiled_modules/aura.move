module 0x45992b10911a78dde0c7ecff3f52425f012d46067dc4b58cfcc7d78ca5e107f6::aura {
    struct AURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURA>(arg0, 6, b"Aura", b"Sui Aura", x"537569204175726120697320696e6372656469626c652e2045766572792073696e676c65206d656d6520746f6b656e2069732067726f77696e672c206761696e73206172652068697474696e67206576657279207365636f6e642e2053756920417572612e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZV_83a9_WMAI_8_Pk_S_c8a5933851.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

