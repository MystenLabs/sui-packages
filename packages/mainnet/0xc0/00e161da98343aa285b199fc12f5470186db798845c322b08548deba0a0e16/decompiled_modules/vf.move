module 0xc000e161da98343aa285b199fc12f5470186db798845c322b08548deba0a0e16::vf {
    struct VF has drop {
        dummy_field: bool,
    }

    fun init(arg0: VF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VF>(arg0, 6, b"VF", b"Vagina Face", b"RAOUL PAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746835979474.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

