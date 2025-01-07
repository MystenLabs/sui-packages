module 0xe289f5a42ddc7ada206cc75aed7eaefbabfb949aeb9af0bfde588573a0e1055f::gbit {
    struct GBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBIT>(arg0, 9, b"GBIT", b"GIGGLEBITS", x"476967676c654269747320697320612068756d6f722d64726976656e206d656d6520636f696e2077697468206465666c6174696f6e617279206275726e732c20726577617264732c20616e64204e4654207574696c69746965732e0a507572706f73653a20537072656164206a6f7920616e642066696e616e6369616c2066756e2e0a506c616e3a204c61756e6368206f6e204445582c20657870616e64207574696c69746965732c20616e6420666f7374657220612076696272616e7420636f6d6d756e6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12933d7a-f940-44d7-9e78-acf269a1c624.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

