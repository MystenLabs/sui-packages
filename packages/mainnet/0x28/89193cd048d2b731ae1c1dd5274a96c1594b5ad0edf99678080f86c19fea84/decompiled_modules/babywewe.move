module 0x2889193cd048d2b731ae1c1dd5274a96c1594b5ad0edf99678080f86c19fea84::babywewe {
    struct BABYWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYWEWE>(arg0, 9, b"BABYWEWE", b"Babywewe", b"Baby Wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/77e43f4f-f9f3-4af3-a344-abd1995400d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

