module 0x774645e2eb2aee3d738e9d1e016dc7384543810484a7fbb6b55f7b1d9e3c4a95::bkn {
    struct BKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKN>(arg0, 9, b"BKN", b"Bikini", b"Fit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/767e63ed-3e0b-4a81-9172-d1c97cd2c515.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

