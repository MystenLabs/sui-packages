module 0x96055a548474cde6cd218afe0793c6282084caad541d61c1bda90a6713367daa::fg {
    struct FG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FG>(arg0, 9, b"FG", b"Fish Gold", b"Meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a45a7845-302f-4e98-997a-3952d91a2ef5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FG>>(v1);
    }

    // decompiled from Move bytecode v6
}

