module 0x7a627842c124ba8a849231d71b069c085607e30b951541f64e97efd994c969::gap {
    struct GAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAP>(arg0, 9, b"GAP", b"Giap", b"Funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a7e46f8a-678c-498c-bb64-0eff6fb902c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

