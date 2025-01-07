module 0x9367d2a7340a2a4ac60e3390ec84d2bc214dd9bde9ba77279c538d2988971d13::hpy {
    struct HPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPY>(arg0, 9, b"HPY", b"Happily", b"happily is a meme token for bull run that is set to pump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3aa2d8dc-c77d-4e8d-9171-cf0a1e40c00f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

