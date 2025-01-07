module 0x63676c5b4c749c340c49415b22ac963ef7a4dd23ffb71fe7888852c6ba2ab14b::qonke {
    struct QONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QONKE>(arg0, 6, b"QONKE", b"First Qonke On Sui", b"First Qonke On Sui: https://qonkeonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_38_b53adb5eab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

