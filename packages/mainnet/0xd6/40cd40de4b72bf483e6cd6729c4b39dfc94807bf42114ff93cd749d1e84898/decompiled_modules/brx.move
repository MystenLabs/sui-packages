module 0xd640cd40de4b72bf483e6cd6729c4b39dfc94807bf42114ff93cd749d1e84898::brx {
    struct BRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRX>(arg0, 9, b"BRX", b"BadraEX", b"Great and good DEX on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1a3c9ed-bf4e-4047-801d-85925552124a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

