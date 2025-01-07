module 0x1c8618442765171b0960e3ce97b5625d666a9e43963eed47bb1e913bf80448be::suic {
    struct SUIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIC>(arg0, 6, b"SUIC", b"SUICIDE", x"53746179207374726f6e6720616e64206e657665722067697665207570206f6e20535549200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicide_bfd5fef0ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

