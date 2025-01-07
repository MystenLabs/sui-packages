module 0xae5aaacb2eae4a5bfefd6358cbcc5fbfc71b8c26df735d8118bb659a5c81fecc::hehe {
    struct HEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHE>(arg0, 6, b"HEHE", b"HEHE SOL", x"4869206d79206e616d65206973202448454845200a0a4120747275652067616d626c696e67206164646963742077686f20637261766573207269736b20616e64207468726976657320696e2074686520776f726c64206f662063727970746f63757272656e63792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HEHE_e87abb7a90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

