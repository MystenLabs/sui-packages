module 0x9a99790fe05f660c4f4518dee24d0f7aceaf6b74ae146558af85a972f6d8dcd4::mae {
    struct MAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAE>(arg0, 9, b"MAE", b"MarsElon", b"To The Mars WAGMI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4919749-4f28-4134-a2b2-a1837d52be9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

