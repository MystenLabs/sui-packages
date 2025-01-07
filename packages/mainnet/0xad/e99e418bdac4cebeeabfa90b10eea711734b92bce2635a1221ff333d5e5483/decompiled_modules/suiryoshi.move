module 0xade99e418bdac4cebeeabfa90b10eea711734b92bce2635a1221ff333d5e5483::suiryoshi {
    struct SUIRYOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRYOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRYOSHI>(arg0, 6, b"SUIRYOSHI", b"Sui Ryoshi", x"5375692052796f736869206a7573742064726f70706564206f6e205355492c20616e642069742773206c697421205468697320746f6b656e277320676f7420746865207669626573206f662061206368696c6c2073756e7269736520616e642074686520776973646f6d206f6620736f6d6520616e6369656e74206d61737465722c20616c6c20726f6c6c656420696e746f206f6e652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Ryoshi_Logo_d4196b98ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRYOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRYOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

