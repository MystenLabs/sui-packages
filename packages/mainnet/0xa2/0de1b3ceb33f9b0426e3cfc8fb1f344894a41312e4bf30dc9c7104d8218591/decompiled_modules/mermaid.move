module 0xa20de1b3ceb33f9b0426e3cfc8fb1f344894a41312e4bf30dc9c7104d8218591::mermaid {
    struct MERMAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERMAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERMAID>(arg0, 6, b"MERMAID", b"Mermaid Sui", b"Mermaids are mythical creatures known as half-human, half-fish beings, often depicted as having the upper body of a human (usually female) and the lower body of a fish, with a long, flowing t", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730450089652.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MERMAID>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERMAID>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

