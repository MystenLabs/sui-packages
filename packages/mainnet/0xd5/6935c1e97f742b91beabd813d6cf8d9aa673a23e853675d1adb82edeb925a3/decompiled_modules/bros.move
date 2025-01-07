module 0xd56935c1e97f742b91beabd813d6cf8d9aa673a23e853675d1adb82edeb925a3::bros {
    struct BROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROS>(arg0, 6, b"BROS", b"SUI BRO BEAR", x"535549e280a242524fe280a2424541522069732064657269766174697665206f6620424954434f494ee280a242524fe280a24245415220696e20426974636f696e206d656d65636f696e73202852554e4553292e204272696e67696e672074686520737069726974206f6620426974636f696e206d656d657320746f207468652053756920636f6d6d756e69747921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732280622796.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

