module 0x7c7b54bc18389dad71fb6c13052863cc7d9c4c36f429c137772bb16341ce5eab::yogi {
    struct YOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOGI>(arg0, 6, b"YOGI", b"Human Dog", b"Yogi is just a dog with human face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yogi_chantaldesjardins_d286c262b91a4026b4bbc8060e3b437f_52fe32f09b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

