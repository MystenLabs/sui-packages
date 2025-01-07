module 0xbab598c7511c701f6691542846e6a10bee91048d6a8037e8d15f5ac59b5a2936::afd {
    struct AFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFD>(arg0, 9, b"AFD", b"dgdfg", b"gfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d7efcd8-f753-4e36-9fab-3b57f691556f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

