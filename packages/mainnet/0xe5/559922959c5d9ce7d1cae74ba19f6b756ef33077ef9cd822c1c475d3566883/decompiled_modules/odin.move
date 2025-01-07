module 0xe5559922959c5d9ce7d1cae74ba19f6b756ef33077ef9cd822c1c475d3566883::odin {
    struct ODIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ODIN>(arg0, 6, b"ODIN", b"Suichrodinger ", b"Auto trade bot. Auto buy . Auto sell. Like quantic equilibrium.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000045276_8fcf343462.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ODIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

