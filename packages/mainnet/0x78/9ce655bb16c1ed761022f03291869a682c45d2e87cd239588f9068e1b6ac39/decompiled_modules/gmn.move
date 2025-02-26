module 0x789ce655bb16c1ed761022f03291869a682c45d2e87cd239588f9068e1b6ac39::gmn {
    struct GMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMN>(arg0, 9, b"GMN", b"Gimno", b"Gimno token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae56f348-7cf9-4a9a-8488-c901e51a91c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

