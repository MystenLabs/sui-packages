module 0xf09b4b6a3ee0c762df7c3d61307299011f3f384c1e36c57aec93da5d94f55d3d::syra {
    struct SYRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYRA>(arg0, 6, b"SYRA", b"Sui Syra", b"Syra, a  blend feline and aquatic elements that lives in the Sui Sea.  A mythical half-cat, half-mermaid creature.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/merm_5a809c5bb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

