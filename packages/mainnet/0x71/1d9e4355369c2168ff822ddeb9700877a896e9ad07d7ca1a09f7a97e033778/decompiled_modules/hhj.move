module 0x711d9e4355369c2168ff822ddeb9700877a896e9ad07d7ca1a09f7a97e033778::hhj {
    struct HHJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHJ>(arg0, 9, b"HHJ", b"Ghh", b"Gj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/321396c6-1b88-4ed3-ad74-f23477cc7372.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

