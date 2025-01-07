module 0x56020ae088341c46176e952719e4c2fa69f05dc6643c7a120c9445bd0fc6782c::charmvn {
    struct CHARMVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARMVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARMVN>(arg0, 9, b"CHARMVN", b"CHARM", b"Token for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96d7e8e7-bb11-42e9-bbc0-d31c2011da85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARMVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHARMVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

