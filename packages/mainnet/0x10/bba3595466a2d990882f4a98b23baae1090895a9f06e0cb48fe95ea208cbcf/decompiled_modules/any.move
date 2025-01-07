module 0x10bba3595466a2d990882f4a98b23baae1090895a9f06e0cb48fe95ea208cbcf::any {
    struct ANY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANY>(arg0, 9, b"ANY", b"any", b"ANYD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ff33b35-e405-4766-adeb-3785522e85cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANY>>(v1);
    }

    // decompiled from Move bytecode v6
}

