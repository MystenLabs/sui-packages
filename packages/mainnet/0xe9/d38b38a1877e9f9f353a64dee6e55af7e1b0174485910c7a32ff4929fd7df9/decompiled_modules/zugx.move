module 0xe9d38b38a1877e9f9f353a64dee6e55af7e1b0174485910c7a32ff4929fd7df9::zugx {
    struct ZUGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUGX>(arg0, 9, b"ZUGX", b"ZUGXOFF", x"0a5a554720546f6b656e2069732061206675747572697374696320616e642067616c61637469632d696e7370697265642063727970746f63757272656e63792064657369676e656420746f20656d706f77657220696e6e6f766174696f6e2c2073706565642c20616e6420656666696369656e637920696e2074686520626c6f636b636861696e2065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f100a48-6138-4ae4-95cb-e13c382b2b44.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUGX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUGX>>(v1);
    }

    // decompiled from Move bytecode v6
}

