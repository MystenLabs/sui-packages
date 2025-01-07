module 0x5608e6227c0b0ea91b403e0078ab1c5516cf5b164aaff88a26dee63252d07f81::cr7sui {
    struct CR7SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR7SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR7SUI>(arg0, 6, b"CR7SUI", b"CR7SUI *", b"He knows!..suuuuuuuuuuuuuuuuuuuuuuuuuui CR7 edition", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Rsui_615a44e313.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR7SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CR7SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

