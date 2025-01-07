module 0x702e8e49ebda52a0358296ea61abb788ec1ab6ff89af85fa0956c6678586066d::chd {
    struct CHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHD>(arg0, 9, b"CHD", b"ChadFrog", x"4368616446726f672028434844292069732061206d656d6520746f6b656e20636f6d62696e696e672074686520626f6c6420636f6e666964656e6365206f6620436861642077697468207468652074696d656c65737320636861726d206f66207468652046726f672e204275696c7420746f206c6561702070617374206578706563746174696f6e732c204348442c20636865656b79206d656d65732e20486f7020696e206265666f7265206974e280997320746f6f206c6174652120f09f90b8f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/632bc7da-46c3-4571-8d4a-1374850734b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

