module 0x6790ed5e84c500ac25b6563943ff56954b8fdbdf0e2baf8057f569c0ed3ca81e::champ {
    struct CHAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAMP>(arg0, 9, b"CHAMP", b"CHAMPION", b"Token that specifically design for the ultimate winner and champion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ae98c28-9edd-4edb-9041-3e901b7441d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

