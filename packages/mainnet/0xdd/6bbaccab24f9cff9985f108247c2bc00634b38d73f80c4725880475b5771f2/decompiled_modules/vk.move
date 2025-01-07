module 0xdd6bbaccab24f9cff9985f108247c2bc00634b38d73f80c4725880475b5771f2::vk {
    struct VK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VK>(arg0, 9, b"VK", b"vinod kuma", b"Cool ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54b2f667-5c38-4520-a010-d4abb283a6d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VK>>(v1);
    }

    // decompiled from Move bytecode v6
}

