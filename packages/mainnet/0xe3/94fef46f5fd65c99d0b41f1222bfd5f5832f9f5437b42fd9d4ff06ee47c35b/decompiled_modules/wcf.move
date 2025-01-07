module 0xe394fef46f5fd65c99d0b41f1222bfd5f5832f9f5437b42fd9d4ff06ee47c35b::wcf {
    struct WCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCF>(arg0, 9, b"WCF", b"WhoCame1st", b"Who came first, the egg or the chicken?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3fce8a57-e16b-466d-bce0-00e93b404b9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

