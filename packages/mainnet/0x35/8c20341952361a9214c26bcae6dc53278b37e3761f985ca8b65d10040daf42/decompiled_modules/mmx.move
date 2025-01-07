module 0x358c20341952361a9214c26bcae6dc53278b37e3761f985ca8b65d10040daf42::mmx {
    struct MMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMX>(arg0, 9, b"MMX", b"Mboh", b"Community is key", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74e5f5ef-16e5-40d1-b385-8a5cbf6f9eda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMX>>(v1);
    }

    // decompiled from Move bytecode v6
}

