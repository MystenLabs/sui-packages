module 0x5943b99000b8735126151c203651b6565c8e7c32d8c24ab518dbe5eb92c2ccf6::dtc {
    struct DTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTC>(arg0, 9, b"DTC", b"Donald T", x"446f6e616c64205472756d7020436f696e220a54686520446f6e616c64205472756d7020546f6b656e20726570726573656e7473207468652076616c7565732c20696e666c75656e63652c20616e6420706572736f6e616c697479206f6620746865203435746820507265736964656e74206f662074686520556e69746564205374617465732c20446f6e616c64204a2e205472756d702e20496e737069726564206279206869732063617265657220696e20627573696e657373", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00a98ea5-2009-437d-b81e-b903806ad607.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

