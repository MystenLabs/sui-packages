module 0x572fc043904b5041df505b93166f4d1f693fe165d6837fe869aa87d733c4fc40::cmy {
    struct CMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMY>(arg0, 9, b"CMY", b"common", b"common money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ceb9c5ac-1c92-4b5e-8c9c-541daec3ac58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

