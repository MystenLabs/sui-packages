module 0xf810031afebbd9eb5a2595308b24ac6d314435ce47f2d3cb176b3f2f2d1a2ab9::icats {
    struct ICATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICATS>(arg0, 9, b"ICATS", b"ISIM CATS", b"Islamic Cats is a cryptocurrency token that often focuses on community, ethical investing, and entertainment, often appealing to cat enthusiasts. Here are some common features associated with such tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d7f9948-9889-4f3a-9474-437f2806e321.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ICATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

