module 0xb0dc810d07daf30742adf4be6969508581fa2e511d062756262c0caed88e50db::baybys {
    struct BAYBYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAYBYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAYBYS>(arg0, 6, b"BAYBYS", b"BABYSUI", b"If you want to win 10X this is the right place", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/th_ea480d57d8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAYBYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAYBYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

