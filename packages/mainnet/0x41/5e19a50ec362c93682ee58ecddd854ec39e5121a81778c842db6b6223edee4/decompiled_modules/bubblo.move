module 0x415e19a50ec362c93682ee58ecddd854ec39e5121a81778c842db6b6223edee4::bubblo {
    struct BUBBLO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BUBBLO>, arg1: 0x2::coin::Coin<BUBBLO>) {
        0x2::coin::burn<BUBBLO>(arg0, arg1);
    }

    fun init(arg0: BUBBLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLO>(arg0, 9, b"$Bubblo", b"Bubblo", b"Bubblo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbfiCJKhhrXdus8LBpDzTovR4V1uj14YoFE6cHk9hHVak")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUBBLO>(&mut v2, 6000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBBLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

