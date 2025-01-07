module 0x50ae0599d0a56588cf01334dc0c963870bc31dfaee3412aaa5595336ccf4e2b4::suicidal {
    struct SUICIDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDAL>(arg0, 6, b"Suicidal", b"SUIcidal", x"496620697420646f65736e2774207265616368204465782c20506570652077696c6c2074616b6520686973206f776e206c6966652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000066058_5645588310.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICIDAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

