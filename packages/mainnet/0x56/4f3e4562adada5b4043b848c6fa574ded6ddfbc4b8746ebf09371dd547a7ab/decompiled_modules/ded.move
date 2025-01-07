module 0x564f3e4562adada5b4043b848c6fa574ded6ddfbc4b8746ebf09371dd547a7ab::ded {
    struct DED has drop {
        dummy_field: bool,
    }

    fun init(arg0: DED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DED>(arg0, 6, b"DED", b"ded cat", b"the cat is ded  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_Nf2m_E8_I_400x400_744091ef81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DED>>(v1);
    }

    // decompiled from Move bytecode v6
}

