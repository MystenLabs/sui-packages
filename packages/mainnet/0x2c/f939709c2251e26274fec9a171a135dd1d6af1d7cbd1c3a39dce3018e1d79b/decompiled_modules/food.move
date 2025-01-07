module 0x2cf939709c2251e26274fec9a171a135dd1d6af1d7cbd1c3a39dce3018e1d79b::food {
    struct FOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOD>(arg0, 6, b"FOOD", b"Food Roll", b"Let's eat together and fill our stomachs for a while", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009652_84db41c6b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

