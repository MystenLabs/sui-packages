module 0x362689a0f4424b70211a3e516dcdf34b7e57d405133e3721bb628ed9d27375ef::suitrump {
    struct SUITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRUMP>(arg0, 0, b"SUITRUMP", b"SUITRUMP", b"THIS IS SUITRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://meme.rolipoli.xyz/meme-icons/1758549074292_ce865bf1-6631-427e-9949-17275d9a7d75.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUITRUMP>>(0x2::coin::mint<SUITRUMP>(&mut v2, 999, arg1), @0x6dc40a6b35310e5dd5cb7767f8d8477b9c1fc219f0cc511f45928eddaae341dd);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUITRUMP>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

