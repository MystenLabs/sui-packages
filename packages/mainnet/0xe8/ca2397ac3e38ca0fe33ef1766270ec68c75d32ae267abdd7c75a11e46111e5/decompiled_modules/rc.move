module 0xe8ca2397ac3e38ca0fe33ef1766270ec68c75d32ae267abdd7c75a11e46111e5::rc {
    struct RC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RC>(arg0, 9, b"RC", b"Raca", b"Raca rug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24043c19-d87b-4d70-a341-879685033a61.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RC>>(v1);
    }

    // decompiled from Move bytecode v6
}

