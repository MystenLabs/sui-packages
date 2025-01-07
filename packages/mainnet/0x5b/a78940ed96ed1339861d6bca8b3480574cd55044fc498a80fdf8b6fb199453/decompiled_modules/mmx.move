module 0x5ba78940ed96ed1339861d6bca8b3480574cd55044fc498a80fdf8b6fb199453::mmx {
    struct MMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMX>(arg0, 9, b"MMX", b"Mboh", b"Community is key", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4296a8d5-92b3-4794-9dc0-2bac2eb92ed5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMX>>(v1);
    }

    // decompiled from Move bytecode v6
}

