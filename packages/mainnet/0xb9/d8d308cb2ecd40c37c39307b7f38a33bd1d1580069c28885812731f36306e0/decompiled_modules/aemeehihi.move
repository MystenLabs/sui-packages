module 0xb9d8d308cb2ecd40c37c39307b7f38a33bd1d1580069c28885812731f36306e0::aemeehihi {
    struct AEMEEHIHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEMEEHIHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEMEEHIHI>(arg0, 9, b"AEMEEHIHI", b"meme ahihi", x"79e1baa3796133e1bbb56133796d79656d33796179346be1bb87e1bbb57961", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9aa2851d-3add-464d-9aac-517f2663433a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEMEEHIHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AEMEEHIHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

