module 0x206d27f716fc4631217027df880076ca23be53b4ef482bcf0b086253fb5e5b53::tyl {
    struct TYL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYL>(arg0, 9, b"TYL", b"Tuyul", b"a ghost who likes to take other people's money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7364be69-a9c9-43f4-81ff-04ddacf3a11b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYL>>(v1);
    }

    // decompiled from Move bytecode v6
}

