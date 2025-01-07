module 0xabd9be446aff55a559fabdcbee352231374e9124806a6dc79368739c891312f7::touch {
    struct TOUCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOUCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOUCH>(arg0, 6, b"TOUCH", b"TOUCH MEME", x"546f75636820796f757220647265616d0a0a546f75636820796f75722068656172740a0a4c6574206d6520746f75636820796f752c2074616b65206d6520746f20796f75722068656172742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730650305199.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOUCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOUCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

