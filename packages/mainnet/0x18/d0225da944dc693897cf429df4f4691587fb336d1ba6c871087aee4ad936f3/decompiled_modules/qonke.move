module 0x18d0225da944dc693897cf429df4f4691587fb336d1ba6c871087aee4ad936f3::qonke {
    struct QONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QONKE>(arg0, 6, b"QONKE", b"Qonke On Sui", b"quack quack quack ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_300x300_3e3ae56739.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

