module 0xdb8a5a8f208234434077fd034aa098941d23d294adc78a061b3bb6cc83eed95e::ntl {
    struct NTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTL>(arg0, 9, b"NTL", b"Dragon ", b"when whales fly i like it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e8acda7-6da9-41bb-bc3f-2ef2f22b4cbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

