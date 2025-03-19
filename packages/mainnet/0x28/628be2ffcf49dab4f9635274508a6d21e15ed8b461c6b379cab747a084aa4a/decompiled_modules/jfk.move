module 0x28628be2ffcf49dab4f9635274508a6d21e15ed8b461c6b379cab747a084aa4a::jfk {
    struct JFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFK>(arg0, 9, b"JFK", b"Justice for Kennedy", b"John F. Kennedy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSBzHcC22RtfaiRJnwZFKGoaMG5FnqHFc8J4SRBW8a1TM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JFK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JFK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

