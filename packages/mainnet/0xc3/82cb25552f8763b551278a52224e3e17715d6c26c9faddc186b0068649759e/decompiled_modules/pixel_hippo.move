module 0xc382cb25552f8763b551278a52224e3e17715d6c26c9faddc186b0068649759e::pixel_hippo {
    struct PIXEL_HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXEL_HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXEL_HIPPO>(arg0, 9, b"PIXEL HIPPO", b"PIXEL HIPPO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/ryHr1ZC/image.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIXEL_HIPPO>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIXEL_HIPPO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXEL_HIPPO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

