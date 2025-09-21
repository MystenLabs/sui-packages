module 0x50ef0883f0fe41cfed659cc4f367ac2b4e7c1ef150160547a4dd30b48a5a7668::lizard {
    struct LIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIZARD>(arg0, 0, b"LIZARD", b"LIZ", b"LIZARDS EAT INSECTS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://meme.rolipoli.xyz/meme-icons/1758481941060_2ce81bc2-d578-4144-bb50-912f46778020-3.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LIZARD>>(0x2::coin::mint<LIZARD>(&mut v2, 9999, arg1), @0x6dc40a6b35310e5dd5cb7767f8d8477b9c1fc219f0cc511f45928eddaae341dd);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LIZARD>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

