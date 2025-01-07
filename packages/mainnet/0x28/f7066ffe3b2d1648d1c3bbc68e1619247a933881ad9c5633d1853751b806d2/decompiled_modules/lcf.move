module 0x28f7066ffe3b2d1648d1c3bbc68e1619247a933881ad9c5633d1853751b806d2::lcf {
    struct LCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCF>(arg0, 9, b"LCF", b"Lucifer", b"Lucifer is comong ...!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a90d51f-eaf5-4b64-a113-446ca8a653d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

