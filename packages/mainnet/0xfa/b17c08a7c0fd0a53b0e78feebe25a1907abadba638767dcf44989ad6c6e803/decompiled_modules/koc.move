module 0xfab17c08a7c0fd0a53b0e78feebe25a1907abadba638767dcf44989ad6c6e803::koc {
    struct KOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOC>(arg0, 9, b"KOC", b"KingofCup", b"In the realm of tarot, The King of Cups embodies the essence of emotional intelligence and spiritual leadership", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2bbc48b-dca2-4526-9a15-1242576e2435.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

