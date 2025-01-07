module 0x20918a9110299c02d8a40fa75fd22485cbf262ac09278d71139a1a1b35c36c27::void {
    struct VOID has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOID>(arg0, 6, b"VOID", b"Void of Sui", b"$VOID is the abyss that consumes all. Mysterious and endless, its where light fades, and only the unknown remains. Enter if you dare. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_6_660d1991f9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOID>>(v1);
    }

    // decompiled from Move bytecode v6
}

