module 0xdb105a54fcec3060a0818ae65287775ec18b0d8764c7a03f8b0def95b0ee637f::q125488585 {
    struct Q125488585 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q125488585, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q125488585>(arg0, 9, b"Q125488585", b"QQ", b"Handsomeboy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0917079c-4999-4560-a0e4-3f2114424085.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q125488585>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Q125488585>>(v1);
    }

    // decompiled from Move bytecode v6
}

