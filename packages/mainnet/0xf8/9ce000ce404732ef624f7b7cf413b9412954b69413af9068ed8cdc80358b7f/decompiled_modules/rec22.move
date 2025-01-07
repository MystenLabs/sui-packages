module 0xf89ce000ce404732ef624f7b7cf413b9412954b69413af9068ed8cdc80358b7f::rec22 {
    struct REC22 has drop {
        dummy_field: bool,
    }

    fun init(arg0: REC22, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REC22>(arg0, 9, b"REC22", b"Rector22", b"A street funky dog living his best life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a50b6ec2-517c-4515-8e44-7e1e9d776f6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REC22>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REC22>>(v1);
    }

    // decompiled from Move bytecode v6
}

