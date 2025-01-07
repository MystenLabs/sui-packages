module 0x5a56035b1da8680675315a68152f61b9025e0674c5215407f6f41af8fd8dac42::ottr {
    struct OTTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTR>(arg0, 9, b"OTTR", b"Otter", b"Happy Otter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e80b011-4474-4591-9e92-f50312d9272e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

