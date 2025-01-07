module 0x2eb71e5adbdfecfc34414df3c3757c8fd979f046d129603226641f36ab644cc4::njw {
    struct NJW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NJW>(arg0, 9, b"NJW", b"Najwas", b"Family token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e8693c1-1e90-49d8-8da5-85af83175a53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NJW>>(v1);
    }

    // decompiled from Move bytecode v6
}

