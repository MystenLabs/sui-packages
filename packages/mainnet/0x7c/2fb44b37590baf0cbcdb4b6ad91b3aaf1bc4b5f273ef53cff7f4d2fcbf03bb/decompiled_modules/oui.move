module 0x7c2fb44b37590baf0cbcdb4b6ad91b3aaf1bc4b5f273ef53cff7f4d2fcbf03bb::oui {
    struct OUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OUI>(arg0, 6, b"Oui", b"OuiOnSui", b"$OUI  The French Cat on Sui,  Doxed dev, fair launch, original meme & ticker. Inspired by $Michi and Mbappe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/oui_1_56dafff99b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

