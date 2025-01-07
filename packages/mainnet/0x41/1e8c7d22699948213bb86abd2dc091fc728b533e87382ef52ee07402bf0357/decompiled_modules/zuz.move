module 0x411e8c7d22699948213bb86abd2dc091fc728b533e87382ef52ee07402bf0357::zuz {
    struct ZUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUZ>(arg0, 9, b"ZUZ", b"zuz", b"zuz token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf1426bd-3cdc-45c4-8312-01599ba0343f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

