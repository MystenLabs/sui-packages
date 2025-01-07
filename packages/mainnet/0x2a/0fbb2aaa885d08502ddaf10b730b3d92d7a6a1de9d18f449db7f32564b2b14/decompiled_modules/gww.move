module 0x2a0fbb2aaa885d08502ddaf10b730b3d92d7a6a1de9d18f449db7f32564b2b14::gww {
    struct GWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWW>(arg0, 6, b"GWW", b"Girl wif Wood", b"ZALUPA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985519890.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GWW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

