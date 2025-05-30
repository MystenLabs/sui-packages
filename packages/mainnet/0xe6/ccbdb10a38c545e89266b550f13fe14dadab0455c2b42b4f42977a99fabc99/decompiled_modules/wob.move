module 0xe6ccbdb10a38c545e89266b550f13fe14dadab0455c2b42b4f42977a99fabc99::wob {
    struct WOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOB>(arg0, 6, b"WOB", b"Pokewob", x"4a6f696e2074686520776f62626c652e205265666c65637420746865206368616f732e20436f756e74657220746f20746865206d6f6f6e210a574f424255464645542121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibws6nhkwmmixtqiboqbrtelxn53pvj2ak7qti3zzlailzvkbjp3e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

