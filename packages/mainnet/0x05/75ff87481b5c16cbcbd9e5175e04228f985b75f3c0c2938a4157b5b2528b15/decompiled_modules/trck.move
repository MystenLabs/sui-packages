module 0x575ff87481b5c16cbcbd9e5175e04228f985b75f3c0c2938a4157b5b2528b15::trck {
    struct TRCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRCK>(arg0, 9, b"TRCK", b"Truck", b"Truck drivers token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f908107b-00f3-47a4-b857-91f033d42376.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

