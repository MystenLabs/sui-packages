module 0xebe68180fc20ab1f1e2098495ca4e9951c89116bb6c4252a72a292e5598a4663::magma {
    struct MAGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGMA>(arg0, 9, b"Magma", b"Magma Token", b"Magma Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775719112928-0dab6fe960109559ff3c6302a914eb1e.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGMA>>(0x2::coin::mint<MAGMA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGMA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

