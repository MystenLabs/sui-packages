module 0xb3c5e1040629fad2301690b6467fd2a2460551f7d0522b0444337ce2308f9a3b::flow {
    struct FLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOW>(arg0, 9, b"FLOW", b"Flower", b"The Art Of Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b455e515-22fb-4f48-9377-dbef2d519010.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

