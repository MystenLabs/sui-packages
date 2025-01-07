module 0x7ebe4404c550070ea3c417942af1c24f4d8e3b704a90b504244fd377b665197a::kts {
    struct KTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTS>(arg0, 9, b"KTS", b"KTT", b"new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe14fb25-0374-4a74-969f-1abc2c4787bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

