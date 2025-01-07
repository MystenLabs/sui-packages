module 0xb0992b7c19be857b8dc28fbe0b6989e94891848eb9529b65b7748ac5b83b8846::wls {
    struct WLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLS>(arg0, 6, b"WLS", b"World Liberty Sui", x"546865206d656d6520746861742066726f6e742072616e20446f6e616c64205472756d70277320576f726c64204c6962657274792046696e616e6369616c204f6e205355490a57454220616e64205447203a20544241", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WLFSUI_74c43b6921.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

