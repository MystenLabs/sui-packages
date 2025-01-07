module 0xeb68fddb3d10d336b887d926bcd68425ca1eae5e4a8b88213682132d33443021::blm {
    struct BLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLM>(arg0, 9, b"BLM", b"BLUM", x"424c554d206973206120746f6b656e2077697468696e20746865205375692065636f73797374656d2c206163636f6d70616e79696e6720746865202254616220746f204561726e22207472656e642e20424c554d2070726f6d6973657320746f2064656c6976657220616e206578636974696e6720657870657269656e636520616e64206174747261637469766520726577617264732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ff3d3f3-5b1a-4574-bd46-aec1a8391889.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

