module 0x242d7d0f8abfd08b92bb8796e809fa80fbad4636243ad744465055cc0c476cdc::fx {
    struct FX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FX>(arg0, 9, b"FX", b"Fixee coin", b"Beautiful meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11c7e168-086d-4307-83f4-75443f46747f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FX>>(v1);
    }

    // decompiled from Move bytecode v6
}

