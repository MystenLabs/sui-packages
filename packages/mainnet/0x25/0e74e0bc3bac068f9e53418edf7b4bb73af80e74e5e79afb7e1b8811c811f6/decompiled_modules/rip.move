module 0x250e74e0bc3bac068f9e53418edf7b4bb73af80e74e5e79afb7e1b8811c811f6::rip {
    struct RIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIP>(arg0, 9, b"RIP", b"RIP KAMALA", b"Now Kamala is gone, Hodl lets send her off the white house ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a578f43-4289-42b8-94b9-a874d7b06b08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

