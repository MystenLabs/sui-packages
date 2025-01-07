module 0xc34a32cacae05d851ed1140bad0b41f5437788d98d8962d2621291dbdab6e670::thethess {
    struct THETHESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THETHESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THETHESS>(arg0, 9, b"THETHESS", b"Memeish", b"THAT WHAT I DO YOU CAN HELP ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0a03ac0-dc27-4f78-a026-62593c922bba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THETHESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THETHESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

