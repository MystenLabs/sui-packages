module 0xd818e8eab6a32e27baad28417af589e8fcb4599b5bad1463e8c6141ce3635d35::dts {
    struct DTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTS>(arg0, 9, b"DTS", b"DiSol", b"General transaction token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53b1faf3-1bd8-4637-b86a-fc7bcc082021.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

