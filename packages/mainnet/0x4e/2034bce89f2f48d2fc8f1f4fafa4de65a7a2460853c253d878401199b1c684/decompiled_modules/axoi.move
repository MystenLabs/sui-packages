module 0x4e2034bce89f2f48d2fc8f1f4fafa4de65a7a2460853c253d878401199b1c684::axoi {
    struct AXOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOI>(arg0, 6, b"AXOI", b"AxoOnSui", b"Axo the Axolotl | Join our journey from the HopFun trenches to the $SUI oceans", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pink_3e83d23583.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

