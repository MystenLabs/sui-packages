module 0xbcb7237ed088aeec4c0216ccbf9437d8da6d9325a3dccf889c8f6d75608553b8::laf {
    struct LAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAF>(arg0, 9, b"LAF", b"LEAF", x"6c6f76696e6720796f750a546865207261696e20697320737072696e670a4974206d616b6573206d7920736f756c20677265656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0ae365b-e91f-4336-9224-305a3e9266c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

