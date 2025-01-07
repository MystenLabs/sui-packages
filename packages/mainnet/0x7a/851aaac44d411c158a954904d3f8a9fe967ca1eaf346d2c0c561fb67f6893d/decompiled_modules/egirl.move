module 0x7a851aaac44d411c158a954904d3f8a9fe967ca1eaf346d2c0c561fb67f6893d::egirl {
    struct EGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGIRL>(arg0, 6, b"EGIRL", b"E-Girl", x"456769726c20636f696e2069732064656369746174656420746f20616c6c2075206f6e652068616e64207479706572206c6567656e64732c20636f6d65206a6f696e2074686520636f6d6d756e6974792c20616e642062757920757273656c6620616e20456769726c204f72206a75737420727562206f6e65206f7574207572206465636973696f6e2e0a5573652074686520776562736974652077697468207468652066617070696e672c20616e64206e70203b29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_12_b21e142aae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

