module 0xf4770572c06aa15d1878bc67a9d37a92578d8b3406a8979b41dcd0490a3f6eae::elb {
    struct ELB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELB>(arg0, 9, b"ELB", b"ELBAF", b"aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/684250ff-c4c4-46d9-ac64-d54f3aa64e35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELB>>(v1);
    }

    // decompiled from Move bytecode v6
}

