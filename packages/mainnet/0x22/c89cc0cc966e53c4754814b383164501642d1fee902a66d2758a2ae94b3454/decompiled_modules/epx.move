module 0x22c89cc0cc966e53c4754814b383164501642d1fee902a66d2758a2ae94b3454::epx {
    struct EPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPX>(arg0, 9, b"EPX", b"EchoPlex", b"EchoPlex (EPX) is a revolutionary utility token powering an AI-driven, decentralized echo-system for social and environmental impact.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92a07e27-025d-4ed8-81a4-a7751ce4c68e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

