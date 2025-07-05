module 0xee11c9e9e5dd572c719715183ec600637e90e1ad25f7c563766c952c9b905d63::riv {
    struct RIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIV>(arg0, 6, b"RIV", b"Rivian", x"f09f94b920e2809c4275696c7420666f722074686f73652077686f20666c6f772077697468206e617475726520616e6420746563686e6f6c6f67792ee2809d0a0a5468652052697669616e20546f6b656e202852495629206f6e207468652053756920626c6f636b636861696e20697320696e737069726564206279207468652069636f6e696320656c6563747269632076656869636c65206272616e642052697669616e2c20616e642064657369676e656420746f2073796d626f6c6963616c6c7920616e642066756e6374696f6e616c6c79207265666c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751750608564.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

