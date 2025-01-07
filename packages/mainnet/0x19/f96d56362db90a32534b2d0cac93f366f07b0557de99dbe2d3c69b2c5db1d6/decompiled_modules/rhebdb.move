module 0x19f96d56362db90a32534b2d0cac93f366f07b0557de99dbe2d3c69b2c5db1d6::rhebdb {
    struct RHEBDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHEBDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHEBDB>(arg0, 9, b"RHEBDB", b"heiend", b"jendbc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0251113b-6f31-496e-8976-08e59ac9158b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHEBDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHEBDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

