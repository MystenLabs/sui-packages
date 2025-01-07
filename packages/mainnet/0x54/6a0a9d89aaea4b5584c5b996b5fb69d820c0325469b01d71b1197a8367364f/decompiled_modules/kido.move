module 0x546a0a9d89aaea4b5584c5b996b5fb69d820c0325469b01d71b1197a8367364f::kido {
    struct KIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIDO>(arg0, 9, b"KIDO", b"KAIDAWG", b"Kai is a black poodle who like to cuddle, bark at motorcycles and chase people for belly rubs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eaedc977-54ff-4656-99d0-5f41588d066c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

