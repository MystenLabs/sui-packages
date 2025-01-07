module 0x91af5361906286ca75c0deb2b24afa5aac0514fa967fead73a85484db09bec00::jk {
    struct JK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JK>(arg0, 9, b"JK", b"Joker ", b"We love joker ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10f6cb7f-74cd-406a-aea2-f7b5dee3f5ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JK>>(v1);
    }

    // decompiled from Move bytecode v6
}

