module 0xbdfbbb2acceccd6f283222d834e141ac405e1aa023be2fd4519a76e24bd47c55::knk {
    struct KNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNK>(arg0, 9, b"KNK", b"Kenek", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1618e2a2-fc1e-4ebe-9cb7-27cc3949b118.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

