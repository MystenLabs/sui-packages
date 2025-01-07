module 0x1e565aca148fbdd775240efc63cdf28671b76a82f0e5b315ce6bde78da602317::taa {
    struct TAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAA>(arg0, 9, b"TAA", b"Titanic ", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1005672c-b263-4dd8-9aee-ed7bc817585d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

