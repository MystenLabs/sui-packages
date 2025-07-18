module 0x742151f9594a12a41fcab0d1a3b29e977720190c14d76e8e0ddd9751911010e1::wasn {
    struct WASN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASN>(arg0, 2, b"WASN", b"DC Natives", b"EFL Sports League", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arivmarketplace.sirv.com/Restaurant%20Images/nats.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WASN>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASN>>(v1);
    }

    // decompiled from Move bytecode v6
}

