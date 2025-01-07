module 0x64a6952aa29ea1261a99bc171f2f3f0317286c7524d468a79580251ad31432a::ahd {
    struct AHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHD>(arg0, 9, b"AHD", b"AHAD", x"416861642043727970746f5f43756265f09f95b8efb88f20697320686f6d6520746f206c61746573742063727970746f2041697264726f7020616e64206e6f6e2066756e6769626c6520746f6b656e20686561646c696e65732c20757064617465732c2063727970746f20706c6174666f726d206775696465732c20616e642073706f7474696e67206561726c792073746167652063727970746f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ebbfb27-a2f2-4669-9337-909bf4e4d3e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

