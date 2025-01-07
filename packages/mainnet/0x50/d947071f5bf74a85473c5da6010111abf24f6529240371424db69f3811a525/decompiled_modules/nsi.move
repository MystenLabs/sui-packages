module 0x50d947071f5bf74a85473c5da6010111abf24f6529240371424db69f3811a525::nsi {
    struct NSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSI>(arg0, 9, b"NSI", b"Notsui", b"Notsui not pixel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbe9a108-5860-4b18-94bb-0d7c6aea2251.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

