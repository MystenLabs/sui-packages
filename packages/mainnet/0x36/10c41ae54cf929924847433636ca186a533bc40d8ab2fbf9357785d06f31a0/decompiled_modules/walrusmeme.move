module 0x3610c41ae54cf929924847433636ca186a533bc40d8ab2fbf9357785d06f31a0::walrusmeme {
    struct WALRUSMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUSMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUSMEME>(arg0, 9, b"WalrusMEME", b"Walrus Meme", b"Walrus for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/deb969294cf80fc831ea61422c077df6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALRUSMEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUSMEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

