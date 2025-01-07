module 0xed1444e6f64efc035bda1adcab79d03e344f349b75160ef43bd57f552cae0a38::rcn {
    struct RCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCN>(arg0, 9, b"RCN", b"Raccon", b"raccons are fun and playful buy them and see how", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1981f731-6e1e-4fbf-bffa-21cf93eae6c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

