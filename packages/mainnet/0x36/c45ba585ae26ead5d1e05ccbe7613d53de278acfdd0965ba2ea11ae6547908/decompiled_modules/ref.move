module 0x36c45ba585ae26ead5d1e05ccbe7613d53de278acfdd0965ba2ea11ae6547908::ref {
    struct REF has drop {
        dummy_field: bool,
    }

    fun init(arg0: REF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REF>(arg0, 9, b"REF", b"red flower", b"RED FLOWERS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/342aa21c-2452-48c5-a105-5a7e77844ed4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REF>>(v1);
    }

    // decompiled from Move bytecode v6
}

