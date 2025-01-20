module 0xb93b9412c02b5004532e74c59035e72f979c7084bb0135a3c54570fc843e0b19::trumpc {
    struct TRUMPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPC>(arg0, 6, b"Trumpc", b"TRRUMPC", b"$Trump will change your life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/62_Gy7_Wn_L_400x400_b7d5a3ebaf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

