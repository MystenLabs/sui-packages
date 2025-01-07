module 0x3b23063220dadacaab78c0c2d162a46e55de5c0ca1407ab817bd7efb243898c0::wecat {
    struct WECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WECAT>(arg0, 9, b"WECAT", b"Wewe", b"Wewe token is a cryptocurrency named after characters, individuals, animals, artwork, or anything else in an attempt to be humorous, light-hearted, and attract a user base by promising a fun community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/010497b1-9720-4b74-a58c-474f4f58c427.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

