module 0x5bb01c92ab1a83330b634cb23cadd47d93a7602b649612123d556d44d3be4b8a::oui {
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

