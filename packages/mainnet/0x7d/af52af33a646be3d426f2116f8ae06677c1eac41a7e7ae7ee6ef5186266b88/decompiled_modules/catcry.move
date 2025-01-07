module 0x7daf52af33a646be3d426f2116f8ae06677c1eac41a7e7ae7ee6ef5186266b88::catcry {
    struct CATCRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCRY>(arg0, 9, b"CATCRY", b"CatCry", b"Why airdrop ban me :< ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d63ce336-e5dd-41f2-bb81-cd18ccc6d61c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATCRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

