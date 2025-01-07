module 0x282dda5803d6967e8a6065d34c3c86652975b3bbce2c8f43510c7767a0b8f8d5::rm {
    struct RM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RM>(arg0, 9, b"RM", b"Ranma", b"1/2 Ranma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a04eec8-78c2-4c1d-8485-66d6182800d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RM>>(v1);
    }

    // decompiled from Move bytecode v6
}

