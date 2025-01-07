module 0xa270dfbd36128ce80bb9214a678f30a0c0059b580d69b2b18fb98017a544963a::lemr {
    struct LEMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMR>(arg0, 9, b"LEMR", b"LEMUR", b"lemur from madagascar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad78ae53-9073-4c38-8034-8c94731ab1dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEMR>>(v1);
    }

    // decompiled from Move bytecode v6
}

