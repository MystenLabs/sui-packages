module 0x5c9491c6fe03d26c71cdf5f89538a288a3363bae096aa093b82f407758a36ebc::hclub {
    struct HCLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCLUB>(arg0, 6, b"HCLUB", b"Heaven Club", x"416e67656c73206c696b65207065616e75742077696c6c20616c77617973206265206865726520746f206c6966742075732075702e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/j6_P_Jac_Mp_400x400_4287877296.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

