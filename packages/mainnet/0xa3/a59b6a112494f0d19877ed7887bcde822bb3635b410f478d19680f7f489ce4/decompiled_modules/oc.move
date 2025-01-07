module 0xa3a59b6a112494f0d19877ed7887bcde822bb3635b410f478d19680f7f489ce4::oc {
    struct OC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OC>(arg0, 9, b"OC", b"Only cat", b"Only Cat (OC) is a crypto token for cat lovers and fun. Designed for a community of cat enthusiasts, OC brings a playful and humorous vibe to the crypto world while still supporting blockchain innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8cecf93b-7e6f-435b-96be-24d264834719.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OC>>(v1);
    }

    // decompiled from Move bytecode v6
}

