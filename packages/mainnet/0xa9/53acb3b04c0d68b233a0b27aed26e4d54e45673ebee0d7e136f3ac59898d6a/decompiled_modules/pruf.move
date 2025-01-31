module 0xa953acb3b04c0d68b233a0b27aed26e4d54e45673ebee0d7e136f3ac59898d6a::pruf {
    struct PRUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRUF>(arg0, 9, b"PRUF", b"MOV", x"636f696e2077696c6c20626c6f7720757020746865206d61726b65742c206120796f756e6720656e746875736961737420686173207374617274656420686973206a6f75726e6579f09fa493", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c30f5a2-2bf2-442f-a347-803bd41bb0fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

