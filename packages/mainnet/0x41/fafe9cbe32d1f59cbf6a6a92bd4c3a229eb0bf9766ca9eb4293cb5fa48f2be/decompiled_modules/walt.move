module 0x41fafe9cbe32d1f59cbf6a6a92bd4c3a229eb0bf9766ca9eb4293cb5fa48f2be::walt {
    struct WALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALT>(arg0, 6, b"WALT", b"Heisenberg Token", x"596f7520636c6561726c7920646f6e2774206b6e6f772077686f20796f75277265206465616c696e6720776974682e0a49276d206e6f7420696e20746865206d656d652067616d652e204920414d20746865206d656d652067616d6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742317193006.41")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

