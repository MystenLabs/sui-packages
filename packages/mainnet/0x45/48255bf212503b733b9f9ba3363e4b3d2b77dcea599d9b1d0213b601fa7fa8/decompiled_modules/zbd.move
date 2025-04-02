module 0x4548255bf212503b733b9f9ba3363e4b3d2b77dcea599d9b1d0213b601fa7fa8::zbd {
    struct ZBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZBD>(arg0, 6, b"ZBD", b"$ZBD", x"4561726e20746f20706c61790a5f5f2a2a605a4244602a2a5f5f203a203942354553430a0a312920446f776e6c6f6164205a42440a322920436f70792074686520526566657272616c20436f6465203942354553430a33292043726561746520796f7572206163636f756e740a342920436c69636b20746f70206c6566740a352920436c69636b2022456e74657220526566657272616c20436f6465220a362920456e746572207468652039423545534320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0730_8253da19a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

