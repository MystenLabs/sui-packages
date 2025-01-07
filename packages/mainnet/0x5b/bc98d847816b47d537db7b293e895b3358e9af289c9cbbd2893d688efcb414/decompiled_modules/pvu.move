module 0x5bbc98d847816b47d537db7b293e895b3358e9af289c9cbbd2893d688efcb414::pvu {
    struct PVU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVU>(arg0, 9, b"PVU", b"PVU Coin", x"50565520436f696e202d204c75636b7920436c6f7665720a50565520697320612063727970746f63757272656e637920696e737069726564206279207468652074687265652d6c65616620636c6f7665722c2073796d626f6c697a696e67206c75636b20616e6420686f70652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7d26226-33fb-4e47-bd12-0fe3a9c84132.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PVU>>(v1);
    }

    // decompiled from Move bytecode v6
}

