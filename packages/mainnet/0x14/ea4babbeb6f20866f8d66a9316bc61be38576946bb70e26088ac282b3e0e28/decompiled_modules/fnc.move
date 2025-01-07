module 0x14ea4babbeb6f20866f8d66a9316bc61be38576946bb70e26088ac282b3e0e28::fnc {
    struct FNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNC>(arg0, 9, b"FNC", b"Funcoin", b"This coin was created to appreciate all the fun moments we have had in the web3. Let's celebrate it with this meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe58416f-d96d-4fed-8110-c95ca8de73ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

