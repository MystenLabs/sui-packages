module 0x5cfebbe71af72dc913a7d5d511e585e00039bd2cf573fc6c15182c0d19ee7941::vmh {
    struct VMH has drop {
        dummy_field: bool,
    }

    fun init(arg0: VMH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VMH>(arg0, 9, b"VMH", b"vmhoangit", b"vmhoangit1408", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b91f662-eaf6-4aee-b593-769ae92f9764.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VMH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VMH>>(v1);
    }

    // decompiled from Move bytecode v6
}

