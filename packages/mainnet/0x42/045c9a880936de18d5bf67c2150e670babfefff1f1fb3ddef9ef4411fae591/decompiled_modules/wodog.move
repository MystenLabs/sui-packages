module 0x42045c9a880936de18d5bf67c2150e670babfefff1f1fb3ddef9ef4411fae591::wodog {
    struct WODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WODOG>(arg0, 9, b"WODOG", b"Glaimeme", b"Ez.zzzzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e742e7fc-8bd3-43ab-94be-de5ab2ea157b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WODOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

