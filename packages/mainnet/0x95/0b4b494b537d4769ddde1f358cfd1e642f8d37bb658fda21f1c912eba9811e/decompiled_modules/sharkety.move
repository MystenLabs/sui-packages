module 0x950b4b494b537d4769ddde1f358cfd1e642f8d37bb658fda21f1c912eba9811e::sharkety {
    struct SHARKETY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKETY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKETY>(arg0, 6, b"Sharkety", b"Sharkety In Sui", b"Hello Sui army!! whre is my teeth Sharkety the first memecoin on sui will hit 1M cap!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sharkety_8f588afa18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKETY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKETY>>(v1);
    }

    // decompiled from Move bytecode v6
}

