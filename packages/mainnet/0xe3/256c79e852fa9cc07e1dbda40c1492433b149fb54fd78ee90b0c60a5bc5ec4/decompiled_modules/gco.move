module 0xe3256c79e852fa9cc07e1dbda40c1492433b149fb54fd78ee90b0c60a5bc5ec4::gco {
    struct GCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCO>(arg0, 9, b"GCO", b"Tclick", x"47434f2069732061206e6577206d656d6520636f696e20626c656e64696e672068756d6f7220616e642070726f66697420706f74656e7469616c20696e746f206f6e652065636f73797374656d2e204261636b65642062792061207374726f6e6720636f6d6d756e6974792c2077697468207374616b696e6720616e64206275726e696e672066656174757265732c2047434f206f666665727320612066756e20616e6420726577617264696e6720696e766573746d656e7420657870657269656e63652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4885e146-8000-40ad-832c-8dacac57f214.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

