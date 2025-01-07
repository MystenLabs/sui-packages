module 0xc1f34c34ba8929e191c488ea47356e3f12df55cbf830184ca1156a82110d7c3f::msuifuku {
    struct MSUIFUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSUIFUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSUIFUKU>(arg0, 6, b"MSUIFUKU", b"MSUI FUKU", x"0a5468652062656c6f7665642077696665206f662046756b752077686f20736861726520686973206a6f7920616e6420736f72726f772c2066726f6d207369636b6e65737320746f2068656174682c2066726f6d20706f6f7220746f20726963686573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_05_51_53_590831f739.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSUIFUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSUIFUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

