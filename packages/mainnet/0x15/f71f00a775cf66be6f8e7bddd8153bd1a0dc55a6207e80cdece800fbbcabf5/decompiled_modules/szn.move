module 0x15f71f00a775cf66be6f8e7bddd8153bd1a0dc55a6207e80cdece800fbbcabf5::szn {
    struct SZN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZN>(arg0, 9, b"SZN", b"SuiZen", x"496e73706972656420627920e2809c7a656e2ce2809d2073796d626f6c697a696e672062616c616e636520616e6420737472617465677920696e20746865205375692065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3fa73bfcb52c61a1b8a1b4b10ae8cf01blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SZN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

