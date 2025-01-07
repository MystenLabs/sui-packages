module 0x85b9565ab7773c5dfd985eb8a4efa8fb5589e6698b7e764dfab23466ee620e51::fatmommas {
    struct FATMOMMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATMOMMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATMOMMAS>(arg0, 6, b"Fatmommas", b"Fat Mommas", x"426967206c61646965732c20626967206c61756768732c20616e64206576656e20626967676572206761696e732120f09f92b8f09f8d9720466174204d6f6d6d617320436f696e3a20546865206865617679776569676874206368616d70206f66206d656d652063727970746f2e0a0a436865636b206f7574206f757220736f6369616c7320616e64206172742e20496620796f75206c696b6520746f206c6175676820616e64206d616b6520424947206761696e732c20746861742773207768617420466174204d6f6d6d61732069732061626f75742e20436865636b206f7574206f757220544720616e642058206172742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736208047883.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATMOMMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATMOMMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

