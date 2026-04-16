module 0x8954676af04a80b8321292daddb4f693a05c2d6902b7808dff715b3ee9e24bab::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 9, b"Blub", b"Blub", b"Blub Not Buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776272749401-65c060814f3f36795f2391cee9f06154.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUB>>(0x2::coin::mint<BLUB>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

