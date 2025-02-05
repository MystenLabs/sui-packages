module 0x932d0fc8e9498e9fd42a2b0f18ea2408934d30f1dca9c12ffa2e38d8441dc519::patric {
    struct PATRIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATRIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATRIC>(arg0, 6, b"PATRIC", b"PATRICK ON SUI", x"5061747269636b20737461722c20746865206c6f7661626c6520616e642064696d7769747465642073746172666973682066726f6d2062696b696e6920626f74746f6d2c20686173206465636964656420746f2063726561746520686973206f776e206d656d6520746f6b656e2e200a0a57697468207468652068656c70206f6620686973206265737420667269656e642c205370696e6765426f622053717561726570616e74732c205061747269636b7320526f636b20697320626f726e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_05_12_26_48a_PM_59ed96968d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATRIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATRIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

