module 0x2a8518e4ca88204aa87750c02cf6e97207680cbfe7661fd4174ab8469af4728::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 6, b"BUBL", b"bublsu", b"Bubbling on @SuiNetwork to make frens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J_Km_SPN_8_W_400x400_19e9a69f3b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

