module 0x695a6f9d748d7ddd13d3709e650e84a1a1f0a8a25285a4a4cb08fc074ca80410::fv {
    struct FV has drop {
        dummy_field: bool,
    }

    fun init(arg0: FV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FV>(arg0, 9, b"FV", b"k", b"VNC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74f9045d-b2eb-46b4-a9e7-3ad3732be432.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FV>>(v1);
    }

    // decompiled from Move bytecode v6
}

