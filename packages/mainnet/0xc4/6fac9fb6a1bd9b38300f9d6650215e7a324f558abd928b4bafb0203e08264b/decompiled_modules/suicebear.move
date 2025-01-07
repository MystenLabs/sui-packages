module 0xc46fac9fb6a1bd9b38300f9d6650215e7a324f558abd928b4bafb0203e08264b::suicebear {
    struct SUICEBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICEBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICEBEAR>(arg0, 6, b"SUICEBEAR", b"SuiceBear", b"The cutest bear on SUI, bringing bear to the world of memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038134_d9ece3bcf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICEBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICEBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

