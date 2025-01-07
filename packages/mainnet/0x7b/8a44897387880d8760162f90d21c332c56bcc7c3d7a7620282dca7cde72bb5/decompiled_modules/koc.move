module 0x7b8a44897387880d8760162f90d21c332c56bcc7c3d7a7620282dca7cde72bb5::koc {
    struct KOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOC>(arg0, 9, b"KOC", b"KingofCups", b"In the realm of tarot, The King of Cups embodies the essence of emotional intelligence and spiritual leadership", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/467608a4-9621-4470-8919-2e1fa7a8de28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

