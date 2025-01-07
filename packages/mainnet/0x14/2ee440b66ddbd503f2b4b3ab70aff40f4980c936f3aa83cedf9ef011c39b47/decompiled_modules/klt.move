module 0x142ee440b66ddbd503f2b4b3ab70aff40f4980c936f3aa83cedf9ef011c39b47::klt {
    struct KLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLT>(arg0, 9, b"KLT", b"kkk", b"muttt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50479013-5f66-4418-a3e4-7d5f40234334.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

