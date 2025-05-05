module 0xb26a7285e92f60fd6362f3ab9e2617f60ee6ad45818d4bc9fdac746d6dd138b5::fgf {
    struct FGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGF>(arg0, 9, b"FGF", b"helgos9", b"good good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e0c39ebeefaffb694ca6108f3c7ff966blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

