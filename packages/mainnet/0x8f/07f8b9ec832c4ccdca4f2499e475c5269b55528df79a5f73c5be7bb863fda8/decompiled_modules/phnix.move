module 0x8f07f8b9ec832c4ccdca4f2499e475c5269b55528df79a5f73c5be7bb863fda8::phnix {
    struct PHNIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHNIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHNIX>(arg0, 9, b"PHNIX", b"PHOENIX ", x"2450484e49583a20585250277320726573696c69656e742073706972697420616e642069636f6e6963206d6173636f742e0a5748592050484f454e49583f210a5468726f7567686f75742069747320686973746f72792c205852502068617320616c7761797320726573697374656420616e6420726973656e20616761696e2e20526563656e746c792c20746865206d6f7374207369676e69666963616e74206576656e7420686173206265656e2074686520534543206c6177737569742e204d616e792070656f706c652074686f75676874206974206d61726b65642074686520656e64206f66205852502e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fdd3291-161b-48a7-8adc-f931717e9aac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHNIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHNIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

