module 0x1a0781ba7c1280609e5e43032b08d83ef260ea3d560e9560b0a4470fc52d824f::anjum {
    struct ANJUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANJUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANJUM>(arg0, 9, b"ANJUM", b"Zahid", b"This is nice coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db39bb86-8167-4730-b984-1406849bfda8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANJUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANJUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

