module 0x787a54313a60db51597cd04594a72dc895bd01c23578d3c6b060af1c84b5af8::gsfd {
    struct GSFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSFD>(arg0, 9, b"GSFD", b"FDHD", b"SCG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a17dd968-2803-4c90-bbbd-d3ac913637f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

