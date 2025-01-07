module 0x8f3ad9082650a5a4e341496208efa2acb2fbb504b22c82c0d4c69a4f27fc3120::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 9, b"DUCK", b"Ducks", x"4475636b20436f696e20697320612066756e2c20636f6d6d756e6974792d64726976656e206d656d6520636f696e20696e7370697265642062792065766572796f6e65e2809973206661766f72697465206269726421204a6f696e2074686520666c6f636b2c207368617265206c61756768732c20616e6420776174636820796f757220696e766573746d656e7420776164646c652069747320776179207468726f756768207468652063727970746f206d61726b65742e20517561636b20796f75722077617920746f20746865206d6f6f6e2077697468204475636b20436f696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66075ee5-6dfb-4be6-bc9d-c521ccf32246-Untitled design.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

