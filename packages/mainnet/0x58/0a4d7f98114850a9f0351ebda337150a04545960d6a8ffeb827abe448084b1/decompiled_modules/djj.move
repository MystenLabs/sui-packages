module 0x580a4d7f98114850a9f0351ebda337150a04545960d6a8ffeb827abe448084b1::djj {
    struct DJJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJJ>(arg0, 9, b"DJJ", b"Uudud", b"Dnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9605c66b-d954-43d7-bbe4-7b4dba74abb7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

