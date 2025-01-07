module 0xe8b857ca02c1143034d99f81e9c1110662cbb4b3be2be392fdc807ef00b9a248::trumpbull {
    struct TRUMPBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPBULL>(arg0, 9, b"TRUMPBULL", b"UPTRUMP", b"Donal Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee2da490-ff70-401a-a874-2464d26e578b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

