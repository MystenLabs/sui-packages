module 0xdd39dff47c2b791ccbd9254eff0ae024eb10a2a49d519f558f6af477ee244f97::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIPSY>(arg0, 6, b"Tipsy", b"TipsyOnSui", b"The only $Tipsy is the only drunk narwhal narrative and is here to stay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifugnw7yqpts534icciici4dwiqabngq5ckgx7p4es22r2hijh22a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIPSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TIPSY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

