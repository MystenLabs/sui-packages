module 0x276fe49039d7cfe8b12c7ba9d939eca5bf58cf8c9b194d54994737ee80296df5::tee {
    struct TEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEE>(arg0, 9, b"TEE", b"Teevee", b"Success", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0136ccc4-bbca-44dc-83aa-56787b5310f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

