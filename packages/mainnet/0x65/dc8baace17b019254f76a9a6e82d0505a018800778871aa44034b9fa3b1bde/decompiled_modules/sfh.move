module 0x65dc8baace17b019254f76a9a6e82d0505a018800778871aa44034b9fa3b1bde::sfh {
    struct SFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFH>(arg0, 9, b"SFH", b"Safe hands", b"All about charity token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ddc9e97b-5bae-4aab-b77f-b53f7dbeb417.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

