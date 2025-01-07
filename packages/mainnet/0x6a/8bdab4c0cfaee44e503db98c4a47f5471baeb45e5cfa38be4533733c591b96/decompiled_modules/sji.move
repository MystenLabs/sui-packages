module 0x6a8bdab4c0cfaee44e503db98c4a47f5471baeb45e5cfa38be4533733c591b96::sji {
    struct SJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJI>(arg0, 9, b"SJI", b"Saiji", b".. purely meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a07f2fb-9ae4-4433-8b87-c5edc9ad98c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

