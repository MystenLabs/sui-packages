module 0xc415740c0dc0ed35fc9ab575236097075b748c07ea5249d6183f5227e6d4ea21::lon {
    struct LON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LON>(arg0, 9, b"LON", b"lon", b"hihi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18f17a71-f352-42e6-b1f9-415bbc1929df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LON>>(v1);
    }

    // decompiled from Move bytecode v6
}

