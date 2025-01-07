module 0xc85cca8a580dd40cbd610b4f3f76b001f044fbe513ac4f65f0fde15e11164be::chop {
    struct CHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOP>(arg0, 6, b"CHOP", b"Chop on Sui", b"Chop is the ultimate memecoin inspired by everyones favorite dog from GTA V! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chopimage_021c8610d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

