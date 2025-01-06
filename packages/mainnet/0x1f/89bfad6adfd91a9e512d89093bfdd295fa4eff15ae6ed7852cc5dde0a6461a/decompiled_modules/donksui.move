module 0x1f89bfad6adfd91a9e512d89093bfdd295fa4eff15ae6ed7852cc5dde0a6461a::donksui {
    struct DONKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DONKSUI>(arg0, 6, b"DONKSUI", b"Sui Donkey Ai by SuiAI", b"a Donkey - also a God", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/esekaiaiai_dfae805c51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DONKSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

