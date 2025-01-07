module 0x92d10d9be370a73421da720570fcd665f08361c02e5b594895009e2cb9fb968::pvu {
    struct PVU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVU>(arg0, 9, b"PVU", b"PVU Coin", x"0a50565520436f696e202d204c75636b7920436c6f7665720a0a50565520697320612063727970746f63757272656e637920696e737069726564206279207468652074687265652d6c65616620636c6f7665722c2073796d626f6c697a696e67206c75636b20616e6420686f70652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/452bc730-1217-4b06-93d9-6142693f3867.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PVU>>(v1);
    }

    // decompiled from Move bytecode v6
}

