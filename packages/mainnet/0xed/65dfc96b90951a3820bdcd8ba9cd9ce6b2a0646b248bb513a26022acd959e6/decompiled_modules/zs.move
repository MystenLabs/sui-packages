module 0xed65dfc96b90951a3820bdcd8ba9cd9ce6b2a0646b248bb513a26022acd959e6::zs {
    struct ZS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZS>(arg0, 9, b"ZS", b"ZEUS", b"keep pushing until you cum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f4b9d12-7b91-4a9d-aa44-f99c2e5088be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZS>>(v1);
    }

    // decompiled from Move bytecode v6
}

