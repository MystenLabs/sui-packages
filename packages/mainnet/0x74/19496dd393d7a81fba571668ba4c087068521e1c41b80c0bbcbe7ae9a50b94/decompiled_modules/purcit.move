module 0x7419496dd393d7a81fba571668ba4c087068521e1c41b80c0bbcbe7ae9a50b94::purcit {
    struct PURCIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURCIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURCIT>(arg0, 6, b"PURCIT", b"PURCIT SUI", b"The Mischievous Vampire Cat on Sui!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O9k_Sf0_NB_400x400_66d559356c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURCIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURCIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

