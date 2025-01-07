module 0xc782bbe223cf0a238a5fe719c0c46804920cbf89bbfe89f16a60841199cdbbe5::hds {
    struct HDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDS>(arg0, 9, b"HDS", b"Hades", b"Hades nerver die", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9d64b04-54d5-4e9a-b483-c7150c0bda76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

