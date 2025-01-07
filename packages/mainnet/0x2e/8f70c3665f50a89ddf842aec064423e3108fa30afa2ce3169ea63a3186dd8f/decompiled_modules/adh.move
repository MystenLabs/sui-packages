module 0x2e8f70c3665f50a89ddf842aec064423e3108fa30afa2ce3169ea63a3186dd8f::adh {
    struct ADH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADH>(arg0, 9, b"ADH", b"BEACH", b"DREAM BEACH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0523aeb9-0f91-46eb-9cd2-a1aee36b8dcf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADH>>(v1);
    }

    // decompiled from Move bytecode v6
}

