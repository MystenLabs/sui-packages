module 0x5ef243022e0993c94cd33467d0271d6ab89d114fb9d3e1ac967351987a4bb2a2::syra {
    struct SYRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYRA>(arg0, 6, b"SYRA", b"SUI SYRA", b"Syra, a  blend feline and aquatic elements that lives in the Sui Sea of degens. AKA a mythical half-cat, half-mermaid creature.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/merm_b98ced2c4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

