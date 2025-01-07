module 0x96c83fc5316f4b8584773bfb113b5a98be16bd127165181e726b152293526120::usb {
    struct USB has drop {
        dummy_field: bool,
    }

    fun init(arg0: USB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USB>(arg0, 6, b"USB", b"Unstoppable Badger", b"Because Even Bears Can't Stop This Badger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/USB_Logo_Small_94541e50be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USB>>(v1);
    }

    // decompiled from Move bytecode v6
}

