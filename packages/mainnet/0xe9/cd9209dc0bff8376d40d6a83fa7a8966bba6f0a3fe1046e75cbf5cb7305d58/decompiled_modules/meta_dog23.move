module 0xe9cd9209dc0bff8376d40d6a83fa7a8966bba6f0a3fe1046e75cbf5cb7305d58::meta_dog23 {
    struct META_DOG23 has drop {
        dummy_field: bool,
    }

    fun init(arg0: META_DOG23, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<META_DOG23>(arg0, 9, b"META_DOG23", b"Metadog", b"Meta dog is an AI powered meme coin backed by Meta to enhance the ephesiancy of meta crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f05ec459-d3f3-42cb-b1bd-afdbbd8e1a29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<META_DOG23>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<META_DOG23>>(v1);
    }

    // decompiled from Move bytecode v6
}

