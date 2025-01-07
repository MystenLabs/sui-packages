module 0x2a18bb129b44e2c8227446e5e16589fd74b1c0ebe9329ee3a98974eac296385a::sps {
    struct SPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPS>(arg0, 6, b"SPS", b"SUPPER SUI", b"Hello everyone, we have extensive experience and enough strength to overcome the serious opponents of the SUI system", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_28_20_57_36_330b7a7857.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

