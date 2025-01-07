module 0x1886209413c1b1819b5392c369b916afbddd901977abc72138380baa06ddd099::tips {
    struct TIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIPS>(arg0, 9, b"TIPS", b"Tips Meme", b"Because Tips like meme just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7cd15f95-39b5-489d-ad14-c60d9a003fa9-Screenshot_2024-10-06-04-20-25-206_com.miui.gallery.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

