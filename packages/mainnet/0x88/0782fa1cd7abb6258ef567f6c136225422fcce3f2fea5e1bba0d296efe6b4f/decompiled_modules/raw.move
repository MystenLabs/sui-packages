module 0x880782fa1cd7abb6258ef567f6c136225422fcce3f2fea5e1bba0d296efe6b4f::raw {
    struct RAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAW>(arg0, 6, b"Raw", b"ahah", b"asdads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956296946.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

