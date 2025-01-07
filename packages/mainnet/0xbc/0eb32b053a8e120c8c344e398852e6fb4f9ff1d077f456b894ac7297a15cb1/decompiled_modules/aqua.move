module 0xbc0eb32b053a8e120c8c344e398852e6fb4f9ff1d077f456b894ac7297a15cb1::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 9, b"AQUA", b"SUIMAN", x"4865206973207468652070726f746563746f72206f662074686520646565702c207468652072756c6572206f662041746c616e7469732c20616e6420746865206368616d70696f6e206f6620616c6c2074686174206c6965732062656e65617468207468652077617665732e205768656e207468652074696465732063616c6c20616e64206461726b6e65737320746872656174656e732c206f6e65206e616d65206563686f6573207468726f75676820746865207761746572732e2e2e205355494d414e21200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c6702aa-5577-492a-8484-9532fd5adc7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

