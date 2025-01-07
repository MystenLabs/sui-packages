module 0xaaff73da204fb347023cd7eb3869281f874e58fcbf1d187c76f9f8456ab89f42::koc {
    struct KOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOC>(arg0, 9, b"KOC", b"KingofCups", b"In the realm of tarot, The King of Cups embodies the essence of emotional intelligence and spiritual leadership", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44e7f18d-ce4a-4a93-a67a-9bc48ba89ece.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

