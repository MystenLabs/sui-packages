module 0x6afe2a4dac1049994c309d167aa613ae29a9a258732ceb014afc1b91cdc72d24::miko {
    struct MIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKO>(arg0, 9, b"MIKO", b"Mikail ", b"To expand my knowledge and experience with the cyroptocurrency ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee8198ba-2227-4259-a777-42cd3cd0ccc4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

