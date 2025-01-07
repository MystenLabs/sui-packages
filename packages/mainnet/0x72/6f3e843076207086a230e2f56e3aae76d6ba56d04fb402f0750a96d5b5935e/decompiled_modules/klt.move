module 0x726f3e843076207086a230e2f56e3aae76d6ba56d04fb402f0750a96d5b5935e::klt {
    struct KLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLT>(arg0, 9, b"KLT", b"kkk", b"muttt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9efaac3-ad59-41c9-8f87-b3d4e7d6e7b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

