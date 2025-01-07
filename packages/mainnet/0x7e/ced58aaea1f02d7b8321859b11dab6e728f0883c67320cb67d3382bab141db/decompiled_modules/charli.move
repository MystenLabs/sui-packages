module 0x7eced58aaea1f02d7b8321859b11dab6e728f0883c67320cb67d3382bab141db::charli {
    struct CHARLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARLI>(arg0, 9, b"CHARLI", b"CHARLI DOG", b"in memeory of a loyal friend CHARLI THe dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5339c250-4ad1-407e-92ad-9906758982de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHARLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

