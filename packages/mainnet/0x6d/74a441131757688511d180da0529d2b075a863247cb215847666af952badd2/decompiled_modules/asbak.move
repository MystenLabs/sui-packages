module 0x6d74a441131757688511d180da0529d2b075a863247cb215847666af952badd2::asbak {
    struct ASBAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASBAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASBAK>(arg0, 9, b"ASBAK", b"Asbak SUI", b"Asbak on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3527cd77-8f88-4057-8814-3531324324bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASBAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASBAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

