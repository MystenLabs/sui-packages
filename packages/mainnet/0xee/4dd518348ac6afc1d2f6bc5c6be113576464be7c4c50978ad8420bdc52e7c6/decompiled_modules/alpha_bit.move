module 0xee4dd518348ac6afc1d2f6bc5c6be113576464be7c4c50978ad8420bdc52e7c6::alpha_bit {
    struct ALPHA_BIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA_BIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA_BIT>(arg0, 9, b"ALPHA", b"Alpha BIT", b"ALPHA the bigg project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776006625069-3507df9fddcfe3dd1aaf72d2ce0ae87d.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ALPHA_BIT>>(0x2::coin::mint<ALPHA_BIT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALPHA_BIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA_BIT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

