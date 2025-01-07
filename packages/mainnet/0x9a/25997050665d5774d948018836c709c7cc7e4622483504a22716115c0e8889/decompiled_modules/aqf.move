module 0x9a25997050665d5774d948018836c709c7cc7e4622483504a22716115c0e8889::aqf {
    struct AQF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQF>(arg0, 9, b"AQF", b"HDS", b"AF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/813330bf-8026-4432-a7fd-76800340324f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AQF>>(v1);
    }

    // decompiled from Move bytecode v6
}

