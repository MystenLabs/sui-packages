module 0x106e7a98c7b26db1b3a07f5fe2816b62d4017cce392ed51dc05ff50d7c118521::wan {
    struct WAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WAN>(arg0, 6, b"WAN", b"Wan Sui by SuiAI", b"Wansui is a fair-launch platform. Each coin has no presale and no team allocation. Wansui prevents rugs by making sure that all created tokens are safe..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4s_82i_JI_400x400_61abdcd9f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

