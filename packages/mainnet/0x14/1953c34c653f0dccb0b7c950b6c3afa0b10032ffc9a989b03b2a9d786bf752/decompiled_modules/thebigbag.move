module 0x141953c34c653f0dccb0b7c950b6c3afa0b10032ffc9a989b03b2a9d786bf752::thebigbag {
    struct THEBIGBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEBIGBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEBIGBAG>(arg0, 9, b"THEBIGBAG", b"SUI-T-CASE", x"5375692062726f756768742074686520626167204d462e2053686f756c642077652064726f70207468652062616720617420446578206f722074616b6520697420746f204365782e20666f72206e6f726d616c2070656f706c65206974277320746865206d6f6f6e2062757420666f72206d652069742773207468652053554e21206e6f20582c206e6f207765622e206a75737420796f7520616e6420796f757220626167e29c85616e6420492063616e277420727567f09fa5b269206f776e206c657373207468616e203125206f662074686520626167f09fa5b2f09f98ad206f6b617920492064726f7020746865205447", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d080deee-cff0-4295-9449-67959559f61e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEBIGBAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEBIGBAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

