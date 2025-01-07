module 0xceabee7aa792508cb43743d23a46c21c5c99a57250e68107b95657b8858e54ec::wss {
    struct WSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSS>(arg0, 9, b"WSS", b"Wolf SS", b"coin meme nice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3cba798-e511-4249-8945-5573246693ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

