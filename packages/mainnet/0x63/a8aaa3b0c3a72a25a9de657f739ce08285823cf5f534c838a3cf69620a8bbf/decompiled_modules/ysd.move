module 0x63a8aaa3b0c3a72a25a9de657f739ce08285823cf5f534c838a3cf69620a8bbf::ysd {
    struct YSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: YSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YSD>(arg0, 9, b"YSD", b"Yes Drop", b"Meme of Yes Drop Game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b62b8ffa-15ed-42fc-8ce1-ca1d6dec9b62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

