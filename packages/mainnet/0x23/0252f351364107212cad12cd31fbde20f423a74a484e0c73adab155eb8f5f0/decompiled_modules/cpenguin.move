module 0x230252f351364107212cad12cd31fbde20f423a74a484e0c73adab155eb8f5f0::cpenguin {
    struct CPENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPENGUIN>(arg0, 6, b"CPENGUIN", b"Club Penguin", b"The $CPENGUIN token is here to take over! With the upcoming release of a brand-new on chain Penguin Adventure game, this isnt just a memeits your ticket to fun and profit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241216_152749_262_6d1a7b6df4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPENGUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPENGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

