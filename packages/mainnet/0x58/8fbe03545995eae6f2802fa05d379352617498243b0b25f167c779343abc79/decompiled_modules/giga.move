module 0x588fbe03545995eae6f2802fa05d379352617498243b0b25f167c779343abc79::giga {
    struct GIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGA>(arg0, 6, b"GIGA", b"GIGACHAD ON SUI", x"4769676163686164206f6e207375692c796f752077616e7420796f7572207365636f6e64206368616e6365203f0a0a616c6c20736f6369616c732077696c6c2062652075706461746564206265666f726520646578", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giga_chad_color_d5cdc88432.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

