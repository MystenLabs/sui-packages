module 0xe56dbe720783fe456d892cfb583061dfbfd21433ffaa2c50e8a769faef2e59b6::vk {
    struct VK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VK>(arg0, 9, b"VK", b"Vinod Kuma", b"Cool ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79d35784-24bb-4dd8-89fe-c1bbf9725cd7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VK>>(v1);
    }

    // decompiled from Move bytecode v6
}

