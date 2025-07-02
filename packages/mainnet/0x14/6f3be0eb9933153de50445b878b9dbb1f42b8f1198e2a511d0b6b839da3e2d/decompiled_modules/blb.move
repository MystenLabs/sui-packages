module 0x146f3be0eb9933153de50445b878b9dbb1f42b8f1198e2a511d0b6b839da3e2d::blb {
    struct BLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLB>(arg0, 9, b"BLB", b"BLBU", b"OFFICIAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3d97786069f21402e80ad75104e36b90blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

