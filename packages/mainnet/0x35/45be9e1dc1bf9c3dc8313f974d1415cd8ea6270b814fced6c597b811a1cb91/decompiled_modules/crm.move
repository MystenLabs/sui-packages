module 0x3545be9e1dc1bf9c3dc8313f974d1415cd8ea6270b814fced6c597b811a1cb91::crm {
    struct CRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRM>(arg0, 9, b"CRM", b"CROMI", b"Cromi is a type of chocolate that is 75% bitter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/051aedce-8b1c-41b1-a497-24b2a55f1ed3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

