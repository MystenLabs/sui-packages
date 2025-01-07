module 0x9f700035819d849a0372a7ffe318acb4bb5e83876adc2e112187dbc971731a::kos {
    struct KOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOS>(arg0, 6, b"KOS", b"KunOnSui", x"4a7573742061206b69642077686f206861736e277420636175676874206120627265616b2c20676f6e6e61206d616b652069742068617070656e206f6e20535549200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KUN_7e40f9d628.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

