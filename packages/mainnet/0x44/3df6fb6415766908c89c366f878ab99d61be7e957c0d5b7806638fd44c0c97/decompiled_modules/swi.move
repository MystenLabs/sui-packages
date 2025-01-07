module 0x443df6fb6415766908c89c366f878ab99d61be7e957c0d5b7806638fd44c0c97::swi {
    struct SWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWI>(arg0, 9, b"SWI", b"Suwei", b"Uniquely indivisible suwei", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/115b88d3-5aaa-42da-b69c-5e74656b30ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

