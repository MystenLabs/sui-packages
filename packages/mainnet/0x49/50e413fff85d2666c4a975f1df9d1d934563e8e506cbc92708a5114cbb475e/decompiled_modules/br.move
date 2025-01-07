module 0x4950e413fff85d2666c4a975f1df9d1d934563e8e506cbc92708a5114cbb475e::br {
    struct BR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BR>(arg0, 9, b"BR", b"Bro", b"Bro to bro ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ff73c92-e476-40f4-a813-337eb8095dee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BR>>(v1);
    }

    // decompiled from Move bytecode v6
}

