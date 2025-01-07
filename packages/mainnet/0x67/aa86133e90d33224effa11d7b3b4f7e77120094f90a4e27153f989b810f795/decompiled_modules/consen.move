module 0x67aa86133e90d33224effa11d7b3b4f7e77120094f90a4e27153f989b810f795::consen {
    struct CONSEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONSEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONSEN>(arg0, 9, b"CONSEN", b"consen", x"f09f92a0204f6365616e207374616e647320617320746865206865617274206f66206f75722054656c656772616d2077616c6c65742c20626f617374696e6720612066616972206c61756e63682e2053696d706c792063726561746520616e206163636f756e7420746f20737461727420796f7572204f6365616e206d696e696e67206a6f75726e65792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2ce896e-e1c5-4cbe-b925-5873018d54a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONSEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONSEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

