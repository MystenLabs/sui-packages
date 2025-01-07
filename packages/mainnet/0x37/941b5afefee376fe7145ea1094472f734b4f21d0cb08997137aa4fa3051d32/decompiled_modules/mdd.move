module 0x37941b5afefee376fe7145ea1094472f734b4f21d0cb08997137aa4fa3051d32::mdd {
    struct MDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDD>(arg0, 6, b"MDD", b"MooDiddy", b"Oil party when I'm free x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cs_Ev_Pn_L8_400x400_1a9da4fa62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

