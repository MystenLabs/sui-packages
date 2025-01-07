module 0xb093830b5354680ceef9a536f6f6fe6e281ca89f8c0a81b83229884496f68101::shk {
    struct SHK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHK>(arg0, 9, b"SHK", b"shark", x"44697665206465657020696e746f2070726f66697473207769746820536861726b436f696e3a2054686520706f77657266756c2063727970746f63757272656e637920746861742773206372756973696e67207468726f75676820746865206d61726b65742c2064656c69766572696e67207368617270206761696e7320616e642074616b696e672061206269672062697465206f7574206f662066696e616e6369616c206f70706f7274756e69746965732120f09fa688f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9674f48f-d5f9-4166-88f8-d1651e4ea6fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHK>>(v1);
    }

    // decompiled from Move bytecode v6
}

