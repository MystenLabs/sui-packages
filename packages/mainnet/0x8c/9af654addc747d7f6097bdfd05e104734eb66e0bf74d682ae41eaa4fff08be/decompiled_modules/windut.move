module 0x8c9af654addc747d7f6097bdfd05e104734eb66e0bf74d682ae41eaa4fff08be::windut {
    struct WINDUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINDUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINDUT>(arg0, 9, b"WINDUT", b"Windah", b"Windah Basudara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/856b1f51-f3f5-4037-b23a-1d968af4165b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINDUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINDUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

