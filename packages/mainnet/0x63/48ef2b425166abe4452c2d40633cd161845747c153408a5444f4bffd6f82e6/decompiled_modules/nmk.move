module 0x6348ef2b425166abe4452c2d40633cd161845747c153408a5444f4bffd6f82e6::nmk {
    struct NMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NMK>(arg0, 9, b"NMK", b"Namek", b"The most efficient solutions for web3. Update your score level. DBZ MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ef032fa-249c-43fb-a065-dd62c55f2f66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

