module 0x8bd6133465578c51fc751a98f3cac48435f6c3e05c8be563b4f56f7b6778029f::lnd {
    struct LND has drop {
        dummy_field: bool,
    }

    fun init(arg0: LND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LND>(arg0, 9, b"LND", b"LINDA", b"$LINDA is a meme token for cat lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65102b69-1eb9-47f9-8827-f95e6a6ad223.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LND>>(v1);
    }

    // decompiled from Move bytecode v6
}

