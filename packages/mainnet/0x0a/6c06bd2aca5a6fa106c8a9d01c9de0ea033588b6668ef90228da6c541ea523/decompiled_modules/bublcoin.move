module 0xa6c06bd2aca5a6fa106c8a9d01c9de0ea033588b6668ef90228da6c541ea523::bublcoin {
    struct BUBLCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBLCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBLCOIN>(arg0, 6, b"Bublcoin", b"BUBL", x"427562626c696e67206f6e20405375694e6574776f726b746f206d616b65206672656e732e0a537465616c7468206c61756e6368203d20657175616c206368616e6365732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731009872352.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBLCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBLCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

