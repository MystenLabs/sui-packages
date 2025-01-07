module 0xadca7a98c7f63666ae93b2a7008ed2eeea4aef4db0a712f741849152ace820ba::vnm {
    struct VNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNM>(arg0, 9, b"VNM", b"VNmobile", b"Vietnamobile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1eb37e2-9e60-498a-b6ef-3ef48e99aab1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

