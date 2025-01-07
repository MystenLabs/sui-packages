module 0x19fe0a531096b533ae4f96648bd1668d14fc9995955e9358ab4b3f66a8f160a8::kjh {
    struct KJH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KJH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KJH>(arg0, 9, b"KJH", b"uh", b"fg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1bdda85-e8ac-4c07-bc0c-6d6a4d7bab4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KJH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KJH>>(v1);
    }

    // decompiled from Move bytecode v6
}

