module 0xdccced5ab67e55cc7798addeb09873764baf01f119e44ea51a01f28da32f4b6::wariii {
    struct WARIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARIII>(arg0, 9, b"WARIII", b"THEEND", b"Wars and Rumors of Wars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf3632c6-5b28-4deb-93e9-82eacc4d4f34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

