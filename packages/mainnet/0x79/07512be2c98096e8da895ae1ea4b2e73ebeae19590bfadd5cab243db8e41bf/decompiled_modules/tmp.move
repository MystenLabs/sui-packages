module 0x7907512be2c98096e8da895ae1ea4b2e73ebeae19590bfadd5cab243db8e41bf::tmp {
    struct TMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMP>(arg0, 9, b"TMP", b"Trump", b"Trump meme for wewe project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1bdb1a20-7b23-4b2c-a075-20fd6ef2ef6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

