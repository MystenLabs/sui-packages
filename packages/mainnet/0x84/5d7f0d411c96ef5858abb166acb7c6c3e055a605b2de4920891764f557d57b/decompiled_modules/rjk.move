module 0x845d7f0d411c96ef5858abb166acb7c6c3e055a605b2de4920891764f557d57b::rjk {
    struct RJK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RJK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RJK>(arg0, 9, b"RJK", b"Ranjit", b"Crypto airdrop ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/abb7d064-6ec5-4ed0-aee7-3c3d6e5d2b67.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RJK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RJK>>(v1);
    }

    // decompiled from Move bytecode v6
}

