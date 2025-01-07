module 0x15e54b8f7e100a10a971fe87375cbafac9ac22d630e402cb83ad8fafd743fc2f::yc {
    struct YC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YC>(arg0, 9, b"YC", b"Yamcha", b"YAMCHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7f3fdce-2db1-41b3-85e3-490ea4b440d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YC>>(v1);
    }

    // decompiled from Move bytecode v6
}

