module 0x4acf3a8ca49047f3459ec93d966ff0e89107f179163a6ea09444ed51b3db62a1::chikoman {
    struct CHIKOMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIKOMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIKOMAN>(arg0, 9, b"CHIKOMAN", b"Chiko", b"Be a chiko", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c544858-d51d-4bfc-a410-393108a4df2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIKOMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIKOMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

