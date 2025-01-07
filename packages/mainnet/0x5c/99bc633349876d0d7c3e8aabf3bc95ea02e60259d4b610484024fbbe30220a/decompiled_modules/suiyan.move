module 0x5c99bc633349876d0d7c3e8aabf3bc95ea02e60259d4b610484024fbbe30220a::suiyan {
    struct SUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYAN>(arg0, 6, b"SUIYAN", b"Super Suiyan", x"537570657220536179616e206973206865726520746f20627265616b206c696d69747320616e6420676f206265796f6e6420e28094206368616e6e656c696e672074686520756e73746f707061626c6520656e65726779206f66206120747275652053756979616e2077617272696f722e20496e7370697265642062792074686520706f776572206f66205375692c207765e280997265207265646566696e696e672077686174206974206d65616e7320746f2065766f6c76652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953485893.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIYAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

