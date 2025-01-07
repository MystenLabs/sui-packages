module 0xfb1b9d9716b30bf7af6d602961e51c58bcf00f988c1c299c10d00239f3694f32::tsu {
    struct TSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSU>(arg0, 9, b"TSU", b"Tsunami ", x"5473756e616d692069732061206469676974616c20746f6b656e206f6e207468652053756920626c6f636b636861696e206f66666572696e672066617374207472616e73616374696f6e7320616e64206c6f7720666565732e20496e737069726564206279207473756e616d692077617665732c206974207265666c6563747320696e6e6f766174696f6e20616e6420666c756964697479207768696c6520737570706f7274696e6720696e636c75736976652c2065636f2d667269656e646c7920644170707320666f72206120736d61727465722c207375737461696e61626c652066696e616e6369616c206675747572652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/568c6ffd-daf0-474b-9c16-16de2dc0942a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

