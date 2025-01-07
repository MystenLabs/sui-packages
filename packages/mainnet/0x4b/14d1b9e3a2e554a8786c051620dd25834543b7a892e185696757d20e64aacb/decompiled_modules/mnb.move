module 0x4b14d1b9e3a2e554a8786c051620dd25834543b7a892e185696757d20e64aacb::mnb {
    struct MNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNB>(arg0, 9, b"MNB", b"Moonbix", x"4d6f6f6e62697820697320e2808be2808b6120676f6c64206d696e696e672067616d652072656c65617365642062792074686520776f726c642773206c656164696e672065786368616e67652042696e616e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcf763f8-1710-4662-95cb-0787387b90b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

