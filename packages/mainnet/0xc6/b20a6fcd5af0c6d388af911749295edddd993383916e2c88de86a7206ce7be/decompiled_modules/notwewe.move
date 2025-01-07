module 0xc6b20a6fcd5af0c6d388af911749295edddd993383916e2c88de86a7206ce7be::notwewe {
    struct NOTWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTWEWE>(arg0, 9, b"NOTWEWE", b"NOTW3W3", b"Only together we are strong. Make NOTWEWE great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/325b516f-6895-480a-a4e3-fb72fed17e5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

